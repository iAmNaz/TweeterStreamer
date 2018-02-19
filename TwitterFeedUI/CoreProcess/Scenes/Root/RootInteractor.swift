//
//  RootInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

/**
  Manages some high level none core operations
 */
protocol RootInteractorProtocol {
    var appInteractor: AppInteractor! { get set }
    var presenter: RootPresenterProtocol! { get set }
    func loadAuthNeeded()
    func loadAuthorized()
    func loadFeed(forKeyword keyword: String)
    func resumed(withKeyword: String)
    func connectingToAPI()
    func hasFinishedConnecting()
    func connectionError(error: Error?)
}

class RootInteractor: RootInteractorProtocol {
    var appInteractor: AppInteractor!
    var presenter: RootPresenterProtocol!
    
    func loadAuthorized() {
        presenter.presentFeedView()
    }
    
    func loadAuthNeeded() {
        presenter.presentAuthView()
    }
    
    func loadFeed(forKeyword keyword: String) {
        appInteractor.start(keyword: keyword)
    }
    
    func resumed(withKeyword: String) {
        presenter.presentCached(keyword: withKeyword)
    }
    
    func connectingToAPI() {
        presenter.presentProgress()
    }
    
    func hasFinishedConnecting() {
        presenter.presentReadyFeed()
    }
    
    func connectionError(error: Error?) {
        presenter.present(error: error)
    }
}
