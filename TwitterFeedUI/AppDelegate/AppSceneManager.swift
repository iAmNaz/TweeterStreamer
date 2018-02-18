//
//  AppRouter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class AppSceneManager: AppSceneManagerProtocol {
    var controller: AppControllerProtocol!
    var rootScene: RootInteractorProtocol!
    
    func loadAuthorizedScene() {
        rootScene.loadAuthorized()
    }

    func loadAuthScene() {
        rootScene.loadAuthNeeded()
    }
}
