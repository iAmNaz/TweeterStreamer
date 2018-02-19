//
//  TwitterAuthentication.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

extension TwitterAPI {
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                self.session = session
            }
            completionBlk(error)
        })
    }
    
    func authenticated() -> Bool {
        let store = Twitter.sharedInstance().sessionStore
        return store.existingUserSessions().count > 0
    }
    
    func deauthorizeClient() {
        let store = Twitter.sharedInstance().sessionStore
        store.reload()
        
        for case let session as TWTRSession in store.existingUserSessions()
        {
            store.logOutUserID(session.userID)
        }
    }
}
