//
//  TwitterUser.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit
struct TwitterUser:UserProtocol {
    var session: TWTRSession?
    
    var screenName: String
    func authorized() -> Bool {
        return session != nil && session?.authToken != nil
    }
}
