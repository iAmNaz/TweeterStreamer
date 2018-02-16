//
//  LoginInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

protocol LoginInteractorProtocol {
    func authenticate()
    func didAuthenticate()
}

class LoginInteractor: LoginInteractorProtocol {
    var appInteractor: AppInteractorProtocol!
    var presenter: LoginPresenterProtocol!
    
    func authenticate() {
        appInteractor.authenticate()
    }
    
    func didAuthenticate() {
        presenter.dismissLoginView()
    }
}
