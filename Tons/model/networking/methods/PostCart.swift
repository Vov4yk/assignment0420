//
//  PostCart.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import Alamofire

class PostCart {
    private let path = "cart"
    private var currentRequest: DataRequest?
    
    private lazy var service = RESTService()
    
    //MARK: - internal
    internal func request(cart: Cart, _ completion: @escaping (Result<Cart, Error>)->()) {
        if let uncompleted = currentRequest {
            print("cancel")
            uncompleted.cancel()
        }
        currentRequest = service.request(.post, components: [path], body: body(for: cart)) { [weak self] (result) in
            self?.currentRequest = nil
            switch result {
            case .success(let data):
                do {
                    let cart = try JSONDecoder().decode(Cart.self, from: data)
                    completion(.success(cart))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - private
    private func body(for cart: Cart) -> Data {
        return try! JSONEncoder().encode(CartRequest(cart: cart))
    }
}
