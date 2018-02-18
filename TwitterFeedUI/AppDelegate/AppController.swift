//
//  AppController.swift
//  ProductCatalog
//
//  Created by Nazario Mariano on 27/10/2017.
//  Copyright © 2017 Nazario Mariano. All rights reserved.
//

import UIKit

class AppController: NSObject, AppControllerProtocol {
    var sceneManager: AppSceneManagerProtocol!
    var app: AppInteractorProtocol!
    
    func didLaunch() {
        startServices()
        displayUI()
    }
    
    func remoteAPI() -> APIProtocol {
        return app.remoteAPI()
    }
    
    func dataStore() -> DataStoreProtocol {
        return self.app.dataStore()
    }
    
    //MARK: - Private
    private func displayUI() {
        if app.userCanUseApp() {
            sceneManager.loadAuthorizedScene()
        }else{
            sceneManager.loadAuthScene()
        }
    }
    
    private func startServices() {
        app.initilizeServices()
    }
    
    func pauseFeed() {
        
    }
    
    func authenticated() -> Bool {
        return app.userCanUseApp()
    }
    
    func didBecomeActive() {
        app.resumeStream()
    }
    
    func sentToBackground() {
        app.stopStreaming()
        app.emptyPersistentStore()
    }
}
