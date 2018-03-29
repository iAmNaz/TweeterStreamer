//
//  TwitterAuthentication.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

@objc //allow overriding of extension
extension TwitterAPI: APIAuthProtocol {
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
        self.client.twitterInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                self.session = session
            }
            completionBlk(error)
        })
    }
    
    func authenticated() -> Bool {
        return self.client.count() > 0
    }
    
    func deauthorizeClient() {
        let store = self.client.twitterInstance().sessionStore
        store.reload()
        
        for case let session as TWTRSession in store.existingUserSessions()
        {
            store.logOutUserID(session.userID)
        }
    }
}
