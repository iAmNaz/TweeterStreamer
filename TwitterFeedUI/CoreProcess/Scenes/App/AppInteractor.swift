//
//  AppInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol AppRoutingLogic
{
    var controller: AppControllerProtocol! { get set }
    func loadLiveFeedScene()
    func loadAuthScene()
}

protocol AppUserSessionProtocol {
    func logout()
    func userCanUseApp()->Bool
}

protocol AppInteractorProtocol: AppUserSessionProtocol {
    func initilizeServices()
    func authenticate()
    func didAuthenticate()
    func didFailAuthentication(error: Error?)
    func didEndSession()
    func didFail(error: Error?)
    func remoteAPI() -> APIProtocol
    func dataStore() -> DataStoreProtocol
    func pauseLiveFeed()
    func startLiveStreamWithKeywod(keyword: String)
}

class AppInteractor: AppInteractorProtocol {
    
    fileprivate var dataStoreRef: DataStoreProtocol!
    fileprivate var routeRef: AppRoutingLogic!
    fileprivate var remoteAPIRef: APIProtocol!

    
    init(dataStore: DataStoreProtocol, router: AppRoutingLogic, remoteAPI: APIProtocol) {
        self.dataStoreRef = dataStore
        self.routeRef = router
        self.remoteAPIRef = remoteAPI
    }
    
    func initilizeServices() {
        remoteAPIRef.initializeService()
    }
    
    func authenticate() {
        remoteAPIRef.authenticateClient()
    }

    func didAuthenticate() {
        
    }
    
    func didFailAuthentication(error: Error?) {
        
    }
    
    func userCanUseApp() -> Bool {
        return remoteAPIRef.authenticated()
    }
    
    func logout() {
        
    }
    
    func didEndSession() {
        
    }
    
    func didFail(error: Error?) {
        
    }
    
    func remoteAPI() -> APIProtocol {
        return self.remoteAPIRef
    }
    
    func dataStore() -> DataStoreProtocol {
        return dataStoreRef
    }
    
    func pauseLiveFeed() {
        
    }
    
    func startLiveStreamWithKeywod(keyword: String){
        remoteAPIRef.reconnect(withKeyword: keyword)
    }
}
