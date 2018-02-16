//
//  AppController.swift
//  ProductCatalog
//
//  Created by Nazario Mariano on 27/10/2017.
//  Copyright © 2017 Nazario Mariano. All rights reserved.
//

import UIKit

class AppController: NSObject, AppControllerProtocol {
    
    var router: AppRoutingLogic!
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
            router.loadLiveFeedScene()
        }else{
            router.loadAuthScene()
        }
    }
    
    private func startServices() {
        app.initilizeServices()
    }
    
    func pauseFeed() {
        
    }
}
