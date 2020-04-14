//
//  Storage.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol Storage {
    associatedtype Item

    var offset: Int { get }
    func getAll() -> [Item]
    func append(_ items: [Item])
    func reset()
}
