//
//  ErrorAlert.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 12.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import UIKit

class ErrorAlert: AppAlert {
    
    override func prepare() -> UIAlertController {
        let alert = UIAlertController(title: ConstanctStrings.error,
                                      message: message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: ConstanctStrings.ok,
                               style: .cancel,
                               handler: nil)
        alert.addAction(ok)
        return alert
    }
}
