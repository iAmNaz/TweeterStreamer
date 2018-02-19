//
//  Configuration.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

/**
 This helps in easily switching which services, live or dummy instances to use
 */
class Configuration {
    static let sharedInstance = Configuration()
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.lowercased().range(of: "fake") != nil {
                return Environment.Fake
            }
        }
        return Environment.Live
    }()
}

enum Environment: String {
    case Fake = "fake"
    case Live = "live"
}

