//
//  GetCart.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

class GetCart {
    private let path = "cart"
    
    private lazy var service = RESTService()
    
    //MARK: - internal
    internal func request(cartId: String, _ completion: @escaping (Result<Cart, Error>)->()) {
        let parameters = ["id" : cartId]
        service.request(.get, components: [path], parameters: parameters) { (result) in
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
}
