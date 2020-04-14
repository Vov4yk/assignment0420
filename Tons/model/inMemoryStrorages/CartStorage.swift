//
//  CartStorage.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol CartStorageProtocol: SingleStorage {
    init(cartId: String)
}

class CartStorage: CartStorageProtocol {
    typealias Item = Cart
    
    private let cartKey = "cart key"
    
    
    //MARK: - CartStorageProtocol
    required init(cartId: String) {
        if let existionCart = get(), existionCart.identifier == cartId {
        } else {
            set(Cart.empty(id: cartId))
        }
    }
    
    //MARK: - SingleStorage
    func get() -> Cart? {
        guard let data = UserDefaults.standard.object(forKey: cartKey) as? Data else {
            return nil
        }
        do {
            let cart = try JSONDecoder().decode(Cart.self, from: data)
            return cart
        } catch (let error) {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
    
    func set(_ item: Cart) {
        do {
            let data = try JSONEncoder().encode(item)
            UserDefaults.standard.set(data, forKey: cartKey)
        } catch (let error) {
            assertionFailure(error.localizedDescription)
        }
    }
    
}
