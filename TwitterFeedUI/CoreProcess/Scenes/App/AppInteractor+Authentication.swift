//
//  AppInteractor+Authentication.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

extension AppInteractor {
    func initilizeServices() {
        remoteAPI().initializeService()
    }
    
    func authenticate() {
        remoteAPI().authenticateClient { (error) in
            if error != nil {
                self.didFailAuthentication(error: error)
            }else {
                self.didAuthenticate()
            }
        }
    }
    
    func didAuthenticate() {
        rootInteractor.loadAuthorized()
    }
    
    func userCanUseApp() -> Bool {
        return remoteAPI().authenticated()
    }
    
    //FIXME
    func didFailAuthentication(error: Error?) {
        
    }
    
    
}
