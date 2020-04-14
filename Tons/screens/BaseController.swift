//
//  BaseController.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 14.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

protocol BaseController {
    func handle(_ notification: Notification)
    func startModelListen()
    func stopModelListen()
}
