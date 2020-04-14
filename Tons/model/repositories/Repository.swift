//
//  Repository.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol Repository {
    associatedtype Item
    func load()
    func get() -> Item
    func update(_ item: Item)
}
