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
}

protocol RootPresenterProtocol {
    var viewController: RootDisplayProtocol! { get set }
    func presentFeedView()
    func presentAuthView()
}

class RootPresenter: RootPresenterProtocol {
    var viewController: RootDisplayProtocol!

    func presentFeedView() {
        viewController.showFeedView()
    }
    
    func presentAuthView() {
        viewController.showAuthView()
    }
}
