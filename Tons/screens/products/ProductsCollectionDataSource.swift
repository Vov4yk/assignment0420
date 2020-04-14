//
//  ProductsDataSource.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ProductsCollectionDataSource: NSObject, UICollectionViewDataSource {
    private let reusebleIdentifier = "ProductCell";
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repository.getAll().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusebleIdentifier, for: indexPath) as? ProductCell else {
            assertionFailure("wrong cell's class detected")
            return UICollectionViewCell()
        }
        let item = repository.getAll()[indexPath.item]
        
        cell.text.text = "\(item.name): \(item.price)"
        
        let placeholer = UIImage(named: "placeholder")
        if let url = URL(string: item.image) {
            cell.picture.af.setImage(withURL: url, placeholderImage: placeholer)
        } else {
            cell.picture.image = placeholer
        }
        return cell
    }
}
