//
//  AppAlert.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

protocol AppAlerProtocol {
    func prepare() -> UIAlertController
}

class AppAlert: AppAlerProtocol {

    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    func prepare() -> UIAlertController {
        assertionFailure("not allowed in abstract class")
        return UIAlertController();
    }

}
