//
//  CartTableDataSource.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 14.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class CartTableDataSource: NSObject {

    private let reusableId = "CartProductCell"
    private let repository: CartRepository
    fileprivate let calculator = CartSumCalculator()
    
    init(repository: CartRepository) {
        self.repository = repository
    }
}

extension CartTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.getAllProducts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = repository.getAllProducts()[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableId, for: indexPath)  as? CartProductCell else {
            assertionFailure("wrong cell's class detected")
            return UITableViewCell()
        }
        cell.deleage = self
        cell.itemId = item.product.identifier
        cell.name.text = item.product.name
        cell.sum.text = NSString(format: "$ %.2f", calculator.sum(for: item)) as String
        cell.quantity.text = "\(item.quantity)"
        let placeholer = UIImage(named: "placeholder")
        if let url = URL(string: item.product.image) {
            cell.picture.af.setImage(withURL: url, placeholderImage: placeholer)
        } else {
            cell.picture.image = placeholer
        }
        return cell
    }
}

extension CartTableDataSource: CartProductCellDelegate {
    func increase(_ id: UInt64) {
        if let product = repository.getProduct(for: id) {
            repository.increase(product: product)
        }
    }
    
    func decrease(_ id: UInt64) {
        if let product = repository.getProduct(for: id) {
            repository.decrease(product: product)
        }
    }
}
