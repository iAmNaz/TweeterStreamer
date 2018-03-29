//
//  Protocols.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

/**
 Remote backend services' API will need to implement this protocol to be used by the application
 */
protocol APIProtocol {
    var appInteractor: AppInteractorProtocol! { get set }
    func authenticated() -> Bool
    func initializeService()
    func authenticateClient(completionBlk: @escaping (Error?) -> ())
    func reconnect(withKeyword keyword: String)
    func disconnect()
    func deauthorizeClient()
}

/**
 API authentication requirements
 */
protocol APIAuthProtocol {
    func authenticateClient(completionBlk: @escaping (Error?) -> ())
    func authenticated() -> Bool
    func deauthorizeClient()
}

/**
 Any preferred persistent store must implement this protocol
 */
protocol DataStoreProtocol {
    var delegate: DataStoreDelegate? { get set }
    func insert(post: PostProtocol)
    func fetchPost(withId id: String) -> Post?
    func fetchRecent() -> Post?
    func deletePost(withId id: String)
    func truncate()
}

/**
 An app level role that acts as an agent between the platform app and business logic objects
 */
protocol AppControllerProtocol {
    var sceneManager: AppSceneManagerProtocol! { get set }
    var app: AppInteractorProtocol! { get set }
    
    func didLaunch()
    func pauseFeed()
    func remoteAPI() -> APIProtocol
    func dataStore() -> DataStoreProtocol
    func authenticated() -> Bool
    func didBecomeActive()
    func sentToBackground()
}
