//
//  RootInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol RootInteractorProtocol {
    func loadFeed(forKeyword keyword: String)
    
}

class RootInteractor: RootInteractorProtocol {
    var appInteractor: AppInteractor!
    var presenter: RootPresenterProtocol!
    
    func loadFeed(forKeyword keyword: String) {
        appInteractor.startLiveStreamWithKeywod(keyword: keyword)
    }
}

extension RootInteractor: AuthenticationDelegate {
    func didAuthenticate() {
        presenter.presentFeedView()
    }
}
