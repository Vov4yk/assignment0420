//
//  CartBadgeStorageService.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 13.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol AddProductServiceProtocol {
    func add(product: Product)
    func resolvePending()
}

/// Model service. Responcible for adding new products into the cart.
///
/// Notification:
/// - .pendingBadgeUpdated
class AddProductService: AddProductServiceProtocol {
    private lazy var storage = CartBadgeStorage()
    private lazy var cartRepository = CartRepository()

    var badge: Int {
        return storage.get() ?? 0
    }
    
    //MARK: - AddProductServiceProtocol
    /// Add selected product into the cart. Increse badge value that indicates that there are updates in the cart
    /// - Parameter product: Product to be added into the cart
    public func add(product: Product) {
        let current = storage.get() ?? 0
        storage.set(current + 1)
        cartRepository.increase(product: product)
        NotificationCenter.default.post(name: .pendingBadgeUpdated, object: nil)
    }
    
    /// Reset badge value
    public func resolvePending() {
        storage.set(0)
        NotificationCenter.default.post(name: .pendingBadgeUpdated, object: nil)
    }
    
}
