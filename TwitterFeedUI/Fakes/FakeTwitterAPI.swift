//
//  FakeTwitterAPI.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class FakeTwitterAPI: APIProtocol {
    fileprivate var dataProcessor: DataProcessorProtocol
    
    init(dataProcessor: TwitterDataProcessor) {
        self.dataProcessor = dataProcessor
        
    }
    
    
    
    func reconnect(withKeyword keyword: String) {
        
    }
    
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
        completionBlk(nil)
    }

    var appInteractor: AppInteractorProtocol!
    
    func authenticated() -> Bool {
        return false
    }
    
    func initializeService() {
        
    }
    
    func connect() {
        
    }
    
    func disconnect() {
        
    }
}
