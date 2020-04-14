//
//  CartRepository.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import UIKit

protocol CartRepositoryProtocol: Repository {
    func getAllProducts() -> [CartProduct]
    func increase(product: Product)
    func decrease(product: Product)
    func getProduct(for id: UInt64) -> Product?
}

/// Models' service. Manage API and persistant operations with cart.
///
/// Notification:
/// - .cartUpdated
/// - .cartLoadingFail
class CartRepository: Repository {
    typealias Item = Cart
    
    private lazy var getCart = GetCart()
    private lazy var postCart = PostCart()
    private lazy var storage = CartStorage(cartId: self.cardId)
    
    //MARK: - Repository
    public func load() {
        getCart.request(cartId: cardId) { [weak self] (result) in
            self?.handle(response: result)
        }
    }
    
    public func get() -> Cart {
        return storage.get()!
    }
    
    internal func update(_ item: Cart) {
        postCart.request(cart: item) { [weak self] (result) in
            self?.handle(response: result)
        }
    }
    
    //MARK: - CartRepositoryProtocol
    public func getAllProducts() -> [CartProduct] {
        return storage.get()!.products.sorted { (a, b) -> Bool in
            a.product.name < b.product.name
        }
    }
    
    public func increase(product: Product) {
        let quantity: Int = (existing(productId: product.identifier)?.quantity ?? 0) + 1
        var newProductList = allProductsWithout(product.identifier)
        newProductList.append(CartProduct(quantity: quantity, product: product))
        let newCart = Cart(id: storage.get()!.identifier, products: newProductList)
        update(newCart)
    }
    
    public func decrease(product: Product) {
        let quantity: Int = (existing(productId: product.identifier)?.quantity ?? 0) - 1
        var newProductList = allProductsWithout(product.identifier)
        if quantity > 0 {
            newProductList.append(CartProduct(quantity: quantity, product: product))
        }
        let newCart = Cart(id: storage.get()!.identifier, products: newProductList)
        update(newCart)
    }
    
    public func getProduct(for id: UInt64) -> Product? {
        return getAllProducts().first { (p) -> Bool in
            p.product.identifier == id
            }?.product
    }
    
    //MARK: - private
    private func allProductsWithout(_ productId: UInt64) -> [CartProduct] {
        return getAllProducts().filter({ (p) -> Bool in
            p.product.identifier != productId
        })
    }
    
    private func existing(productId: UInt64) -> CartProduct? {
        return getAllProducts().first(where: { (o) -> Bool in
            o.product.identifier == productId
        })
    }
    
    private var cardId: String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
    
    private func handle(response: Result<Cart, Error>) {
        switch response {
        case .success(let cart):
            storage.set(cart)
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        case .failure(let error):
            if let _ = error as? DecodingError {
                NotificationCenter.default.post(name: .cartUpdated, object: nil)
            } else {
                NotificationCenter.default.post(name: .cartLoadingFail, object: nil, userInfo: ["error": error])
            }
        }
    }
}
