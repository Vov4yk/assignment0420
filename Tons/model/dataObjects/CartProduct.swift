//
//  CartProduct.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct CartProduct: Codable, Equatable {
    var quantity: Int
    var product: Product
    
    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case product = "product"
    }
}
