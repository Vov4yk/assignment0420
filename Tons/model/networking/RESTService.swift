//
//  ClientREST.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import Alamofire

class RESTService {
    private let host = HostType.tons.value
    private let defaultCachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    private let defaultTimeout = 15.0
    
    //MARK: - internal
    @discardableResult
    internal func request(_ method: Alamofire.HTTPMethod,
                        components:[String],
                        headers: [String: String] = [:],
                        parameters: [String: String] = [:],
                        cachePolicy: URLRequest.CachePolicy? = nil,
                        timeout: TimeInterval? = nil,
                        body: Data? = nil,
                        _ completion: @escaping (Result<Data, Error>) -> ()) -> DataRequest {
        var urlRequest = URLRequest(url: prepare(components, and: parameters),
                                    cachePolicy: cachePolicy ?? defaultCachePolicy,
                                    timeoutInterval: timeout ?? defaultTimeout)
        urlRequest.allHTTPHeaderFields = prepare(headers)
        urlRequest.httpBody = body
        urlRequest.method = method
        debugPrint(">>> \(urlRequest)")
        let dataRequest = AF.request(urlRequest).responseData { response in
            guard let data = response.data, response.error == nil else {
                completion(.failure(response.error!))
                return
            }
            debugPrint("success");
            completion(.success(data))
        }
        return dataRequest
    }
    
    //MARK: - private
    private var defaultHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
        
    private func prepare(_ pathComponents: [String], and parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = host.scheme
        components.host = host.host
        components.port = host.port
        components.path = resourcePath(host.apiPath, components: pathComponents)
        if !parameters.isEmpty {
            components.queryItems = queryItems(for: parameters)
        }
        //TODO: - comment
        return try! components.asURL()
    }
    
    private func resourcePath(_ apiPath: String, components: [String]) -> String {
        var result = apiPath
        for component in components {
            result = result + "/\(component)"
        }
        return result
    }
    
    private func queryItems(for params: [String: String]) -> [URLQueryItem] {
        var result = [URLQueryItem]()
        for (key, value) in params {
            result.append(URLQueryItem(name: key, value: value))
        }
        return result
    }
    
    private func prepare(_ headers: [String : String]) -> [String: String] {
        return defaultHeaders.merging(headers) { (_, new) -> String in
            new
        }
    }
}
