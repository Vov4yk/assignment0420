//
//  ProductCell.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var text: UILabel!
    @IBOutlet private var selectionPledge: UIView!
    
    override var isHighlighted: Bool {
        didSet {
            selectionPledge.isHidden = !isHighlighted
        }
    }
}
