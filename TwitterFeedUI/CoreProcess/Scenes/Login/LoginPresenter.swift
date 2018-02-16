//
//  LoginPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol LoginDisplayProtocol {
    func showLoginView()
    func hideLoginView()
}

protocol LoginPresenterProtocol {
    func presentLogin()
    func dismissLoginView()
}

class LoginPresenter: LoginPresenterProtocol {
    var viewController: LoginDisplayProtocol!
    
    func dismissLoginView() {
        viewController.hideLoginView()
    }
    
    func presentLogin() {
        viewController.showLoginView()
    }
    
    
    
    
}
