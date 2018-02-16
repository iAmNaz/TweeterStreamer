//
//  Configuration.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

class Configuration {
    static let sharedInstance = Configuration()
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.lowercased().range(of: "dev") != nil {
                return Environment.Dev
            }
        }
        return Environment.Prod
    }()
}

enum Environment: String {
    case Dev = "dev"
    case Prod = "prod"
}
