//
//  Endpoints.swift
//  Tons
//
//  Created by Volodymyr Hyrka on 11.04.2020.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation

public struct Host {
    let scheme: String
    let host: String
    let apiPath: String
    let port: Int?
    
    internal init(scheme: String, host: String, port: Int? = nil, apiPath: String) {
        self.scheme = scheme
        self.host = host
        self.apiPath = apiPath
        self.port = port
    }
}
