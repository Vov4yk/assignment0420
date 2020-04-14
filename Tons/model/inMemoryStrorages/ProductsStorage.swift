//
//  ProductsStorage.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

class ProductsStorage: Storage {
    typealias Item = Product
    
    private var products = [Product]()
    
    //MARK: - Storage
    var offset: Int {
        return products.count
    }
    
    func getAll() -> [Product] {
        return products
    }
 
    func append(_ items: [Product]) {
        products.append(contentsOf: items)
    }
    
    func reset() {
        products = []
    }
}
