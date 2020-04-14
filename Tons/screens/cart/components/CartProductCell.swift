//
//  CartProductCell.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol CartProductCellDelegate: class {
    func increase(_ id: UInt64)
    func decrease(_ id: UInt64)
}

class CartProductCell: UITableViewCell {
    
    weak var deleage: CartProductCellDelegate?
    
    var itemId: UInt64!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var sum: UILabel!
    @IBOutlet var quantity: UILabel!
    
    @IBAction func increase() {
        deleage?.increase(itemId)
    }
    
    @IBAction func decrease() {
        deleage?.decrease(itemId)
    }
}
