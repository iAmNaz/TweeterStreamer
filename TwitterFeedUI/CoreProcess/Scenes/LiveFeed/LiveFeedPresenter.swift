//
//  LiveFeedPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol LiveFeedDisplayProtocol {
    func showKeywordRequest()
    func showLiveFeeds()
    func showAuthView()
    func reloadFeedView(feeds: [String])
}

protocol LiveFeedPresenterProtocol {
    func presentLiveFeeds()
    func presentUpdatedFeeds(feeds: [String])
}

class LiveFeedPresenter: LiveFeedPresenterProtocol {
    var viewController: LiveFeedDisplayProtocol!
    
    func presentLiveFeeds() {
        viewController.showLiveFeeds()
    }
    
    func presentUpdatedFeeds(feeds: [String]){
        viewController.reloadFeedView(feeds: feeds)
    }
}
