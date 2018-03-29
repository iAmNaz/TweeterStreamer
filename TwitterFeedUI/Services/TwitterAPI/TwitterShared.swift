//
//  TwitterShared.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 25/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

protocol TwitterInstanceProtocol {
    func logIn(completion: @escaping TWTRLogInCompletion)
    func sessionCount() -> Int
    func instance() -> Twitter
}

class TwitterShared: NSObject, TwitterInstanceProtocol {
    var session: TWTRSession?
    
    fileprivate var twitter: Twitter!
    
    init(twitter: Twitter) {
        self.twitter = twitter
    }
    
    func logIn(completion: @escaping TWTRLogInCompletion) {
        twitter.logIn { (session, error) in
            self.session = session
            completion(session, error)
        }
    }
    
    func sessionCount() -> Int {
        let store = twitter.sessionStore
        return store.existingUserSessions().count
    }
    
    func instance() -> Twitter {
        return self.twitter
    }
}
