//
//  Protocols.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//
/**
 Temporarily stores user information
 */
protocol UserInfoProtocol {
    var username: String { get set }
}

/**
 Represents the current user logged in
 */
protocol UserAccountProtocol {
    var username: String! { get set }
    func editProfile()
    func save()
    func authorized()->Bool
    func logout()
}

protocol APIProtocol {
    var appInteractor: AppInteractorProtocol! { get set }
    func authenticated() -> Bool
    func initializeService()
    func authenticateClient()
    func reconnect(withKeyword keyword: String)
    func disconnect()
}

protocol DataStoreProtocol {
    func insert()
    func fetchLatest()
}

protocol AppControllerProtocol {
    var router: AppRoutingLogic! { get set }
    var app: AppInteractorProtocol! { get set }
    
    func didLaunch()
    func pauseFeed()
    func remoteAPI() -> APIProtocol
    func dataStore() -> DataStoreProtocol
}

protocol AuthenticationDelegate {
    func didAuthenticate()
}
