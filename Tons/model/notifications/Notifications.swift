//
//  Notifications.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 13.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

//MARK: - Products
extension Notification.Name {
    static let productsUpdated = Notification.Name("products have been updated")
    static let productLoadingFail = Notification.Name("products loading has been failed")
}

//MARK: - Cart
extension Notification.Name {
    static let cartUpdated = Notification.Name("cart has been updated")
    static let cartLoadingFail = Notification.Name("cart loading has been failed")
}

//MARK: - Add Product
extension Notification.Name {
    static let pendingBadgeUpdated = Notification.Name("number of pending products to review has been changed")
}

