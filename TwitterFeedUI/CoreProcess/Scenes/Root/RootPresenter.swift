//
//  RootPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol RootDisplayProtocol {
    func showFeedView()
    func showFeedView(withModels: [String])
    func showLoadingFeeds()
    func showAuthView()
    func showKeyword(keyword: String)
    func showLoading()
    func hideStatus()
    func show(error: String)
}

protocol RootPresenterProtocol {
    var viewController: RootDisplayProtocol! { get set }
    func presentFeedView()
    func presentAuthView()
    func presentCached(keyword: String)
    func presentProgress()
    func presentReadyFeed()
    func present(error: Error?)
}

class RootPresenter: RootPresenterProtocol {
    var viewController: RootDisplayProtocol!

    func presentFeedView() {
        viewController.showFeedView()
    }
    
    func presentAuthView() {
        viewController.showAuthView()
    }
    
    func presentCached(keyword: String) {
        viewController.showKeyword(keyword: keyword)
    }
    
    func presentProgress() {
        viewController.showLoading()
    }
    
    func presentReadyFeed() {
        viewController.hideStatus()
    }
    
    func present(error: Error?) {
        if error != nil {
            viewController.show(error: (error?.localizedDescription)!)
        }else{
            viewController.show(error: "An error has occured")
        }
    }
}
