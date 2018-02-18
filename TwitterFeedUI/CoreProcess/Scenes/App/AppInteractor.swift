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
    func userCanUseApp()->Bool
}

protocol AppInteractorProtocol: AppUserSessionProtocol {
    var rootInteractor: RootInteractorProtocol! { get set }
    func initilizeServices()
    func authenticate()
    func didAuthenticate()
    func didFailAuthentication(error: Error?)
    func didFail(error: Error?)
    func remoteAPI() -> APIProtocol
    func dataStore() -> DataStoreProtocol
    func startLiveStreamWithKeywod(keyword: String)
    func savePost(post: PostProtocol)
    func fetch(withId id: String) -> Post?
    func fetchRecentPost()
    func removePost(withId id: String)
    func emptyPersistentStore()
    func stopStreaming()
    func resumeStream()
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
    
    func didFail(error: Error?) {
        
    }
    
    func remoteAPI() -> APIProtocol {
        return self.remoteAPIRef
    }
    
    func dataStore() -> DataStoreProtocol {
        return dataStoreRef
    }
    
    func startLiveStreamWithKeywod(keyword: String){
        cachedKeyword = keyword
        remoteAPIRef.reconnect(withKeyword: keyword)
        liveFeedInteractor.resumeLiveFeed()
    }
    
    func resumeStream() {
        guard let kw = cachedKeyword else {
            return
        }
        remoteAPIRef.reconnect(withKeyword: kw)
        liveFeedInteractor.resumeLiveFeed()
        rootInteractor.resumed(withKeyword: kw)
    }
    
    func savePost(post: PostProtocol) {
        dataStore().insert(post: post)
    }
    
    func fetch(withId id: String) -> Post? {
        return dataStore().fetchPost(withId: id)
    }
    
    func removePost(withId id: String) {
        dataStore().deletePost(withId: id)
    }
    
    func fetchRecentPost() {
        guard let post = dataStore().fetchRecent() else {
            return
        }
        
        if !realTimeFeed {
            liveFeedInteractor.pushFeed(withId: post.id)
        }
    }
    
    func emptyPersistentStore() {
        dataStore().truncate()
    }
    
    func stopStreaming() {
        remoteAPIRef.disconnect()
        liveFeedInteractor.stopFeeds()
    }
}

extension AppInteractor: DataStoreDelegate {
    func didInsert(post: Post) {
        if realTimeFeed {
            liveFeedInteractor.pushFeed(withId: post.id)
        }
    }
}
