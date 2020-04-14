//
//  SingleStorage.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol SingleStorage {
    associatedtype Item
    
    func get() -> Item?
    func set(_ item: Item)
}
