//
//  RootPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol RootDisplayProtocol {
    func showFeedView()
    func showAuthRequiredView()
    func showProgress()
    func hideStatus()
    func show(message: String)
    func showKeyword(keyword: String)
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
        viewController.showAuthRequiredView()
    }
    
    func presentCached(keyword: String) {
        viewController.showKeyword(keyword: keyword)
    }
    
    func presentProgress() {
        viewController.showProgress()
    }
    
    func presentReadyFeed() {
        viewController.hideStatus()
    }
    
    func present(error: Error?) {
        if error != nil {
            viewController.show(message: (error?.localizedDescription)!)
        }else{
            viewController.show(message: "An error has occured")
        }
    }
}
