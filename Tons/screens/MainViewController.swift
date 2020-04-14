//
//  MainViewController.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 13.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController, BaseController {
    
    var counter = 0
    private lazy var addProductService = AddProductService()

    //MARK: - lify cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startModelListen()
    }
    
    deinit {
        stopModelListen()
    }
    
    //MARK: - private
    @objc internal func handle(_ notification: Notification) {
        switch notification.name {
        case .pendingBadgeUpdated:
            update(badge: addProductService.badge, for: targetController)
        default: break
        }
    }
    
    internal func startModelListen() {
        NotificationCenter.default.addObserver(self, selector: #selector(handle(_:)), name: .pendingBadgeUpdated, object: nil)
    }
    
    internal func stopModelListen() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private var targetController: UIViewController? {
        guard let cartControllerNavigation = viewControllers?.first(where: { (controller) -> Bool in
            guard let navController = controller as? UINavigationController else {
                return false
            }
            return navController.viewControllers.first?.isKind(of: CartViewController.self) ?? false
            }) else {
                return nil
        }
        return cartControllerNavigation
    }
    
    private func update(badge: Int, for controller: UIViewController?) {
        if badge > 0 {
            controller?.tabBarItem.badgeValue = "\(badge)"
        } else {
            controller?.tabBarItem.badgeValue = nil
        }
    }

}
