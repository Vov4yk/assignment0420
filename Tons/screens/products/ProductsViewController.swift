//
//  ProductsViewController.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductsViewController: UIViewController, BaseController {
    
    private let displayingOffsetBeforeNextPage = 10;
    private let productsRepo = ProductRepository()
    private lazy var addProductService = AddProductService()
    private lazy var dataSource = ProductsCollectionDataSource(repository: productsRepo)

    @IBOutlet private var collection: UICollectionView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startModelListen()
        title = ConstanctStrings.shopping.capitalized;
        collection.delegate = self
        collection.dataSource = dataSource
        initialLoad()
    }
    
    deinit {
        stopModelListen()
    }
    
    //MARK: - private
    @objc internal func handle(_ notification: Notification) {
        switch notification.name {
        case .productsUpdated:
            collection.reloadData()
        case .productLoadingFail:
            let message = (notification.userInfo?["error"] as? Error)?.localizedDescription ?? "Some Network Error"
            present(ErrorAlert(message: message).prepare(), animated: true, completion: nil)
        default: break
        }
    }
    
    private func initialLoad() {
        productsRepo.load(next: ProductRepository.defaultLimit)
    }
    
    internal func startModelListen() {
        NotificationCenter.default.addObserver(self, selector: #selector(handle(_:)), name: .productsUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(_:)), name: .productLoadingFail, object: nil)
    }
    
    internal func stopModelListen() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productsRepo.getAll()[indexPath.item]
        addProductService.add(product: product)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == productsRepo.getAll().count - displayingOffsetBeforeNextPage {
            productsRepo.load(next: ProductRepository.defaultLimit)
        }
    }
}
