//
//  FakeDataStore.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class FakeDataStore: NSObject, DataStoreProtocol {
    var delegate: DataStoreDelegate?
    
    func fetchPost(withId id: String) -> Post? {
        return nil
    }
    
    func fetchPosts(timeStamp: Int) -> Post? {
        return nil
    }
    
    func insert(post: PostProtocol) {
        
    }
    
    func insert() {
        
    }
    
    func fetchLatest() {
        
    }
}
