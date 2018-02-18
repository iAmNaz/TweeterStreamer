//
//  AppInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//


protocol AppSceneManagerProtocol
{
    var rootScene: RootInteractorProtocol! { get set }
    var controller: AppControllerProtocol! { get set }
    func loadAuthorizedScene()
    func loadAuthScene()
}

protocol AppUserSessionProtocol {
    func logout()
    func userCanUseApp()->Bool
}

protocol AppInteractorProtocol: AppUserSessionProtocol {
    var rootInteractor: RootInteractorProtocol! { get set }
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
    func savePost(post: PostProtocol)
    func fetch(withId id: String) -> Post?
}

protocol DataStoreDelegate {
    func didInsert(post: Post)
}

class AppInteractor: AppInteractorProtocol {
    var rootInteractor: RootInteractorProtocol!
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    
    fileprivate var dataStoreRef: DataStoreProtocol!
    fileprivate var routeRef: AppSceneManagerProtocol!
    fileprivate var remoteAPIRef: APIProtocol!

    init(dataStore: DataStoreProtocol, router: AppSceneManagerProtocol, remoteAPI: APIProtocol) {
        self.dataStoreRef = dataStore
        self.dataStoreRef.delegate = self
        self.routeRef = router
        self.remoteAPIRef = remoteAPI
        self.remoteAPIRef.appInteractor = self
    }
    
    func initilizeServices() {
        remoteAPIRef.initializeService()
    }

    func authenticate() {
        remoteAPIRef.authenticateClient { (error) in
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
    
    func savePost(post: PostProtocol) {
        dataStore().insert(post: post)
    }
    
    func fetch(withId id: String) -> Post? {
        return dataStore().fetchPost(withId: id)
    }
}

extension AppInteractor: DataStoreDelegate {
    func didInsert(post: Post) {
        liveFeedInteractor.pushFeed(withId: post.id)
    }
}
