//
//  getProducts.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import Alamofire

class GetProducts {
    private let path = "products"
    
    private lazy var service = RESTService()
    
    //MARK: - internal
    internal func request(limit: Int, offset: Int, _ completion: @escaping (Result<[Product], Error>) -> () ) {
        let parameters = ["limit": "\(limit)", "offset": "\(offset)"]
        service.request(.get, components: [path], parameters: parameters) { (result) in
            switch result {
            case .success(let data):
                do {
                    let users = try JSONDecoder().decode([Product].self, from: data)
                    completion(.success(users))
                } catch(let e) {
                    completion(.failure(e))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

