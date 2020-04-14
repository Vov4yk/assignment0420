//
//  CardViewController.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit
import AlamofireImage

class CartViewController: UIViewController, BaseController {
    
    private let repository = CartRepository()
    private let addProductService = AddProductService()
    private lazy var dataSource = CartTableDataSource(repository: repository)
    @IBOutlet private var table: UITableView!
    
    //MARK: - live cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startModelListen()
        table.dataSource = dataSource
        table.tableFooterView = UIView()
        title = ConstanctStrings.cart.capitalized
        initialLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addProductService.resolvePending()
    }
    
    deinit {
        stopModelListen()
    }
    
    //MARK: - private
    private func initialLoad() {
        repository.load()
    }
    
    internal func startModelListen() {
        NotificationCenter.default.addObserver(self, selector: #selector(handle(_:)), name: .cartUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handle(_:)), name: .cartLoadingFail, object: nil)
    }
    
    internal func stopModelListen() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc internal func handle(_ notification: Notification) {
        switch notification.name {
        case .cartUpdated:
            table.reloadData()
        case .cartLoadingFail:
            let message = (notification.userInfo?["error"] as? Error)?.localizedDescription ?? "Some Network Error"
            present(ErrorAlert(message: message).prepare(), animated: true, completion: nil)
        default: break
        }
    }
}
