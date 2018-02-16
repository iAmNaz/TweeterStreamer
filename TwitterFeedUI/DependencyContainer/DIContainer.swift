//
//  DIContainer.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import Dip
import Dip_UI
extension UIViewController {
    enum Tags {
        static let liveFeedView = "liveFeedView"
        static let statusDetailView = "statusDetailView"
        static let loginView = "loginView"
        static let rootView = "rootView"
    }
}

extension AppDelegate {
    func setupDIP(container: DependencyContainer) {
        let dependencyFactory = DependencyFactory()
        let feedInteractor = LiveFeedInteractor()
        let router = AppRouter()
        
        router.liveFeedScene = feedInteractor
        var remoteAPI = dependencyFactory.remoteAPI()
        let appInteractor = AppInteractor(dataStore: dependencyFactory.dataStore(), router: router, remoteAPI: remoteAPI)
        
        remoteAPI.appInteractor = appInteractor
    
        container.register(.singleton){
            LiveFeedInteractor() as LiveFeedInteractorProtocol
        }
        
        container.register(.singleton) { AppController() as AppControllerProtocol }
            .resolvingProperties { (container, controller) in
                var appcontroller = controller
                appcontroller.app = appInteractor
                appcontroller.router = router
        }
        
        container.register(tag: UIViewController.Tags.loginView) { LoginViewController() }
            .resolvingProperties { (container, controller) in
                controller.appController = try! container.resolve() as AppControllerProtocol
                
                let viewController = controller
                let interactor = LoginInteractor()
                interactor.appInteractor = appInteractor
                let presenter = LoginPresenter()
                
                viewController.loginInteractor = interactor
                interactor.presenter = presenter
                presenter.viewController = viewController
        }
        
        container.register(tag: UIViewController.Tags.rootView) { RootViewController() }
            .resolvingProperties { (container, controller) in
                controller.appController = try! container.resolve() as AppControllerProtocol
                
//                let viewController = controller
                let interactor = RootInteractor()
                let presenter = RootPresenter()
                interactor.presenter = presenter
                
//
//                interactor.presenter = presenter
//                presenter.viewController = viewController
        }
        DependencyContainer.uiContainers = [container]
    }
}
