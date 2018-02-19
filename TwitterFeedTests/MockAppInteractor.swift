//
//  MockAppInteractor.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
@testable import TwitterFeedUI

class MockAppInteractor: AppInteractorProtocol {
    var rootInteractor: RootInteractorProtocol!
    
    func didFail(error: APIError?) {
        
    }
    
    func remoteAPI() -> APIProtocol {
        return MockAPI()
    }
    
    func dataStore() -> DataStoreProtocol {
        return MockDataStore()
    }
    
    func start(keyword: String) {
        
    }
    
    func stopStreaming() {
        
    }
    
    func resumeStream() {
        
    }
    
    func didBecomeActive() {
        
    }
    
    func savePost(post: PostProtocol) {
        
    }
    
    func fetch(withId id: String) -> Post? {
        return nil
    }
    
    func fetchRecentPost() {
        
    }
    
    func emptyPersistentStore() {
        
    }
    
    func removePost(withId id: String) {
        
    }
    
    func initilizeServices() {
        
    }
    
    func authenticate() {
        
    }
    
    func didAuthenticate() {
        
    }
    
    func didFailAuthentication(error: Error?) {
        
    }
    
    func logout() {
        
    }
    
    func userCanUseApp() -> Bool {
        return true
    }
    

}
