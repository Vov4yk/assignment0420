//
//  CartBadgeStorage.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 13.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

class CartBadgeStorage: SingleStorage {
    typealias Item = Int
    private let key = "cart badge key"
    
    func get() -> Int? {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    func set(_ item: Int) {
        UserDefaults.standard.set(item, forKey: key)
    }
}
