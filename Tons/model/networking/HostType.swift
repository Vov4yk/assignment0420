//
//  HostType.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

public enum HostType {
    case tons

    internal var value: Host {
        switch self {
        case .tons:
            return Host(scheme: "http", host: "13.48.127.170", port: 3000, apiPath: "")
        }
    }
}
