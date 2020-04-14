//
//  BaseRepository.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol PageableRepository {
    associatedtype Item
    
    func getAll() -> [Item]
    func load(next limit: Int)
}
