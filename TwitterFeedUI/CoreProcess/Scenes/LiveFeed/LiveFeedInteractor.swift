//
//  LiveFeedInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol LiveFeedInteractorProtocol {
    var appInteractor: AppInteractorProtocol! { get set }
    var presenter: LiveFeedPresenterProtocol! { get set }
    func authorized() -> Bool
    func stopFeeds()
    func startLiveFeed()
    func requestAuth()
    func pushFeed(withId id: String)
}

class LiveFeedInteractor: LiveFeedInteractorProtocol {
    var appInteractor: AppInteractorProtocol!
    var presenter: LiveFeedPresenterProtocol!
    var timer = RepeatingTimer()
    func requestAuth() {
        
    }
    
    func startLiveFeed() {
//        timer.eventHandler = {
//            print("timer")
//        }
//        timer.resume()
    }
    
    func pushFeed(withId id: String) {
        guard let post = appInteractor.fetch(withId: id) else{
            return
        }
        presenter.presentPost(post: post)
    }
    
    func authorized() -> Bool {
        return appInteractor.userCanUseApp()
    }

    
    func stopFeeds() {
        
    }
}
