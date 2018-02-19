//
//  MockDataStore.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
@testable import TwitterFeedUI

class MockDataStore: DataStoreProtocol {
    var delegate: DataStoreDelegate?
    
    func insert(post: PostProtocol) {
        
    }
    
    func fetchPost(withId id: String) -> Post? {
        return nil
    }
    
    func fetchRecent() -> Post? {
        return nil
    }
    
    func deletePost(withId id: String) {
        
    }
    
    func truncate() {
        
    }
}
