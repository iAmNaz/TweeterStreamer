//
//  AppInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

/**
 Top level scene manager
 */
protocol AppSceneManagerProtocol
{
    var rootScene: RootInteractorProtocol! { get set }
    var controller: AppControllerProtocol! { get set }
    func loadAuthorizedScene()
    func loadAuthScene()
}

protocol AppDataManagementProtocol {
    func savePost(post: PostProtocol)
    func fetch(withId id: String) -> Post?
    func fetchRecentPost()
    func emptyPersistentStore()
    func removePost(withId id: String)
}

protocol AppClientAuthenticationProtocol {
    func initilizeServices()
    func authenticate()
    func didAuthenticate()
    func didFailAuthentication(error: Error?)
    func logout()
    func userCanUseApp()->Bool
}

/**
 Interacts with services, persistent stores and other interactors
 */
protocol AppInteractorProtocol: AppDataManagementProtocol, AppClientAuthenticationProtocol {
    var rootInteractor: RootInteractorProtocol! { get set }

    func didFail(error: APIError?)
    func remoteAPI() -> APIProtocol
    func dataStore() -> DataStoreProtocol
    func start(keyword: String)
    func stopStreaming()
    func resumeStream()
    func didBecomeActive()
}

protocol DataStoreDelegate {
    func didInsert(post: Post)
}

import Foundation

class AppInteractor: AppInteractorProtocol {

    var rootInteractor: RootInteractorProtocol!
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    var realTimeFeed = false
    
    fileprivate var dataStoreRef: DataStoreProtocol!
    fileprivate var routeRef: AppSceneManagerProtocol!
    fileprivate var remoteAPIRef: APIProtocol!
    fileprivate var cachedKeyword: String?
    
    init(dataStore: DataStoreProtocol, router: AppSceneManagerProtocol, remoteAPI: APIProtocol) {
        self.dataStoreRef = dataStore
        self.dataStoreRef.delegate = self
        self.routeRef = router
        self.remoteAPIRef = remoteAPI
        self.remoteAPIRef.appInteractor = self
    }
    
    func didFail(error: APIError?) {
        rootInteractor.connectionError(error: error)
    }
    
    func remoteAPI() -> APIProtocol {
        return self.remoteAPIRef
    }
    
    func dataStore() -> DataStoreProtocol {
        return dataStoreRef
    }
    
    func start(keyword: String){
        //clear previous
        liveFeedInteractor.stopFeeds()
        emptyPersistentStore()
        
        //load new
        cachedKeyword = keyword
        remoteAPIRef.reconnect(withKeyword: keyword)
        liveFeedInteractor.resumeLiveFeed()
        rootInteractor.connectingToAPI()
    }
    
    func resumeStream() {
        
        if !userCanUseApp() {
            return
        }
        
        guard let kw = cachedKeyword else {
            return
        }
        
        remoteAPIRef.reconnect(withKeyword: kw)
        liveFeedInteractor.resumeLiveFeed()
        rootInteractor.connectingToAPI()
        rootInteractor.resumed(withKeyword: kw)
    }
    
    func stopStreaming() {
        remoteAPIRef.disconnect()
        liveFeedInteractor.stopFeeds()
    }
    
    func logout() {
        stopStreaming()
        emptyPersistentStore()
        remoteAPIRef.deauthorizeClient()
    }
    
    //MARK: - App events
    func didBecomeActive() {
        if userCanUseApp() {
            rootInteractor.loadAuthorized()
        }
    }
}

extension AppInteractor: DataStoreDelegate {
    func didInsert(post: Post) {
        if realTimeFeed {
            liveFeedInteractor.pushFeed(withId: post.id)
        }
    }
}
