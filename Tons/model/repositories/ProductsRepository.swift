//
//  ProductsRepository.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

/// Models' service. Manage API and persistant operations with products.
///
/// Notification:
/// - .productsUpdated
/// - .productLoadingFail
class ProductRepository: PageableRepository {
    
    typealias Item = Product

    private lazy var getProducts = GetProducts()
    private lazy var storage = ProductsStorage()
    
    static public let defaultLimit = 100
    
    //MARK: - PageableRepository
    func getAll() -> [Product] {
        return storage.getAll()
    }

    func load(next limit: Int) {
        let offset = storage.offset
        getProducts.request(limit: limit, offset: offset) { [weak self] (result) in
            switch result {
            case .success(let newProducts):
                self?.storage.append(newProducts)
                NotificationCenter.default.post(name: .productsUpdated, object: nil)
            case .failure(let error):
                NotificationCenter.default.post(name: .productLoadingFail, object: nil, userInfo: ["error": error])
            }
        }
    }    
}
