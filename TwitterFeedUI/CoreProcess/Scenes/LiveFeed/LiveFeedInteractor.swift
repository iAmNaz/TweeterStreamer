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
    func resumeLiveFeed()
    func pushFeed(withId id: String)
    func postDisplayed(id: String)
    func stopFeeds()
    func clearFeeds()
}

import Foundation

class LiveFeedInteractor: LiveFeedInteractorProtocol {
    var appInteractor: AppInteractorProtocol!
    var presenter: LiveFeedPresenterProtocol!
    var timer = RepeatingTimer()

    
    init() {
        timer.interval = 2
    }
    
    func resumeLiveFeed() {
        timer.eventHandler = {
            self.loadRecent()
        }
        timer.resume()
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

    func loadRecent() {
        DispatchQueue.main.async {
            self.appInteractor.fetchRecentPost()
        }
    }
    
    func postDisplayed(id: String) {
        self.appInteractor.removePost(withId: id)
    }
    
    func stopFeeds() {
        timer.suspend()
    }
    
    func clearFeeds() {
        presenter.presentEmptyFeed()
    }
    
}
