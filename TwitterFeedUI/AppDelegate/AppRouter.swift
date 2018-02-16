//
//  AppRouter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class AppRouter: AppRoutingLogic {
    var controller: AppControllerProtocol!
    var liveFeedScene: LiveFeedInteractorProtocol!
    
    func loadLiveFeedScene() {
        liveFeedScene.startLiveFeed()
    }
    
    func loadAuthScene() {
        liveFeedScene.requestAuth()
    }
}
