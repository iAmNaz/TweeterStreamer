//
//  LiveFeedInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol LiveFeedInteractorProtocol {
    var appInteractor: AppInteractorProtocol! { get set }
    func authorized() -> Bool
    
    func reloadFeeds(withKeyword keyword: String)
    func stopFeeds()
    func startLiveFeed()
    func requestAuth()
}

class LiveFeedInteractor: LiveFeedInteractorProtocol {
    var appInteractor: AppInteractorProtocol!
    var presenter: LiveFeedPresenter!
    
    func requestAuth() {
        
    }
    
    func startLiveFeed() {
        
    }
    
    func authorized() -> Bool {
        return appInteractor.userCanUseApp()
    }
    
    func reloadFeeds(withKeyword keyword: String) {
        print("keyword \(keyword)")
        
    }
    
    func stopFeeds() {
        
    }
}
