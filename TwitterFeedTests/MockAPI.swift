//
//  MockAPI.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
@testable import TwitterFeedUI

class MockAPI: APIProtocol {
    var appInteractor: AppInteractorProtocol!
    
    func authenticated() -> Bool {
        return true
    }
    
    func initializeService() {
        
    }
    
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
        completionBlk(nil)
    }
    
    func reconnect(withKeyword keyword: String) {
        
    }
    
    func disconnect() {
        
    }
    
    func deauthorizeClient() {
        
    }
}
