//
//  MockTwitterAPI.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
@testable import TwitterFeedUI

class MockTwitterAPI: TwitterAPI {
    
    override func initializeService() {
        
    }
    
    func creatRequest(endPoint: String) -> URLRequest {
        return URLRequest(url:URL(string: "http://facebook.com")!)
    }
    
    override func authenticated() -> Bool {
        return true
    }
}
