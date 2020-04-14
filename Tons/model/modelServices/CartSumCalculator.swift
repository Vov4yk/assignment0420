//
//  SumManager.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

/// Model's service. Prepare basic businel logic calculation.
class CartSumCalculator {
    
    /// Calculate total sum for product in cart
    /// - Parameter item: Instance to be calculated based on it's price and quantity
    /// - Returns: Total sum for product in cart
    func sum(for item: CartProduct) -> Float {
        return Float(item.quantity) * item.product.price
    }
}
