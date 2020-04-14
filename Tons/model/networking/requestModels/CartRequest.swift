//
//  CartRequest.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 13.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct CartRequest: Codable {
    
    let id: String
    let products: [CartRequestCartProduct]
    
    enum CodingKeys: String, CodingKey {
        case id
        case products
    }
    
    init(cart: Cart) {
        self.id = cart.identifier
        self.products = cart.products.map { CartRequestCartProduct(quantity: $0.quantity, product: CartRequestProduct(id: $0.product.identifier)) }
    }
}

struct CartRequestProduct: Codable {
    let id: UInt64
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    init(id: UInt64) {
        self.id = id
    }
    
}
struct CartRequestCartProduct: Codable {
    
    let quantity: Int
    let product: CartRequestProduct
    
    enum CodingKeys: String, CodingKey {
        case quantity
        case product
    }
    
    init(quantity: Int, product: CartRequestProduct) {
        self.quantity = quantity
        self.product = product
    }
}
