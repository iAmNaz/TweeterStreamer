//
//  FakeTwitterAPI.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class FakeTwitterAPI: APIProtocol {
    func reconnect(withKeyword keyword: String) {
        
    }
    
    var appInteractor: AppInteractorProtocol!
    
    func authenticated() -> Bool {
        return true
    }
    
    func initializeService() {
        
    }
    
    func authenticateClient() {
        
    }
    
    func connect() {
        
    }
    
    func disconnect() {
        
    }
}
