//
//  Product.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

struct Product: Codable, Equatable {
    var identifier: UInt64
    var name: String
    var image: String
    var price: Float
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name = "name"
        case image = "imageURL"
        case price = "pricePerUnit"
    }
}
