//
//  RootPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol RootDisplayProtocol {
    func showFeedView()
}

protocol RootPresenterProtocol {
    func presentFeedView()
}

class RootPresenter: RootPresenterProtocol {
    var viewController: RootDisplayProtocol!

    func presentFeedView() {
        viewController.showFeedView()
    }
}
