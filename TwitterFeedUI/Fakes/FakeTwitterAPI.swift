//
//  FakeTwitterAPI.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class FakeTwitterAPI: APIProtocol, APIAuthProtocol {
    
    var appInteractor: AppInteractorProtocol!
    var loggedIn = false
    fileprivate var dataProcessor: DataProcessorProtocol
    
    init(dataProcessor: TwitterDataProcessor) {
        self.dataProcessor = dataProcessor
        
    }
    
    func authenticated() -> Bool {
        return loggedIn
    }
    
    func initializeService() {
        
    }
    
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
//        completionBlk(AuthError.failedAuthError)
        loggedIn = true
        completionBlk(nil)
    }
    
    func reconnect(withKeyword keyword: String) {
        
    }
    
    func disconnect() {
        
    }
    
    func deauthorizeClient() {
        loggedIn = false
    }
}
