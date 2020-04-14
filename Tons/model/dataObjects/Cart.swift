//
//  Cart.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct Cart: Codable, Equatable {
    var identifier: String
    var products: [CartProduct]
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case products = "products"
    }
    
    init(id: String, products: [CartProduct]) {
        self.identifier = id
        self.products = products
    }
    
    static func empty(id: String) -> Cart {
        return Cart(id: id, products: [])
    }
}
