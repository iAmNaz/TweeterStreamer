//
//  LoginInteractor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

/**
    The link between the app level process and auth entry point
 */
protocol LoginInteractorProtocol {
    var appInteractor: AppInteractorProtocol! { get set }
    func authenticate()
}

class LoginInteractor: LoginInteractorProtocol {
    var appInteractor: AppInteractorProtocol!
    
    func authenticate() {
        appInteractor.authenticate()
    }
}
