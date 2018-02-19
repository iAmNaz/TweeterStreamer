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
        static let parentView = "parentView"
        static let rootView = "rootView"
    }
}

extension LoginViewController: StoryboardInstantiatable {}
extension RootViewController: StoryboardInstantiatable {}
extension FeedTableViewController: StoryboardInstantiatable {}
extension DetailViewController: StoryboardInstantiatable {}

extension AppDelegate {
    func setupDIP() {
        
        registerAppServices()
        registerInteractors()
        registerViewControllers()
        
        DependencyContainer.uiContainers = [container]
    }
    
    func registerAppServices() {
        let dependencyFactory = DependencyFactory()
        container.register(.singleton) { AppSceneManager() as AppSceneManagerProtocol }
            .resolvingProperties { (container, controller) in
                var sceneManger = controller
                    sceneManger.controller = try! container.resolve() as AppControllerProtocol
                    sceneManger.rootScene = try! container.resolve() as RootInteractorProtocol
        }
        
        container.register(.singleton) {
            dependencyFactory.remoteAPI(dataProcessor: TwitterDataProcessor()) as APIProtocol
        }
        
        container.register(.singleton) {
            AppInteractor(dataStore: dependencyFactory.dataStore(), router: try! self.container.resolve() as AppSceneManagerProtocol, remoteAPI: try! self.container.resolve() as APIProtocol) as AppInteractor
            }.resolvingProperties { (container, interactor) in
                let appInteractor = interactor
                    appInteractor.liveFeedInteractor = try! container.resolve() as LiveFeedInteractorProtocol
                    appInteractor.liveFeedInteractor.appInteractor = appInteractor
        }
        
        container.register(.singleton) { AppController() as AppControllerProtocol }
            .resolvingProperties { (container, controller) in
                var appcontroller = controller
                    appcontroller.app = try! container.resolve() as AppInteractor
                    appcontroller.sceneManager = try! container.resolve() as AppSceneManagerProtocol
        }
    }
    
    func registerViewControllers() {
        container.register(tag: UIViewController.Tags.loginView) { LoginViewController()
            }
            .resolvingProperties { (container, controller) in
                controller.appController = try! container.resolve() as AppControllerProtocol
                
                let viewController = controller
                var interactor = try! container.resolve() as LoginInteractorProtocol
                    interactor.appInteractor = try! container.resolve() as AppInteractor
//                let presenter = LoginPresenter()
                
                    viewController.loginInteractor = interactor
//                    interactor.presenter = presenter
//                    presenter.viewController = viewController
        }
        
        container.register(tag: UIViewController.Tags.rootView) { RootViewController() }
            .resolvingProperties { (container, controller) in
                controller.appController = try! container.resolve() as AppControllerProtocol
                
                var interactor = try! container.resolve() as RootInteractorProtocol
                    controller.rootInteractor = interactor
                
                let appInteractor = try! container.resolve() as AppInteractor
                    appInteractor.rootInteractor = interactor
                    controller.appInteractor = appInteractor
                    interactor.appInteractor = appInteractor
                var presenter = try! container.resolve() as RootPresenterProtocol
                    presenter.viewController = controller
                
        }
        
        container.register(tag: UIViewController.Tags.liveFeedView) { FeedTableViewController() }
            .resolvingProperties { (container, controller) in
                    controller.appController = try! container.resolve() as AppControllerProtocol
                    controller.liveFeedInteractor = try! container.resolve() as LiveFeedInteractorProtocol
                let presenter = LiveFeedPresenter()
                    presenter.viewController = controller
                    controller.liveFeedInteractor.presenter = presenter
        }
        
        container.register(tag: UIViewController.Tags.statusDetailView) { DetailViewController() }
            .resolvingProperties { (container, controller) in
                controller.liveFeedInteractor = try! container.resolve() as LiveFeedInteractorProtocol
        }
    }
    
    func registerInteractors() {
        container.register(.singleton) { RootPresenter() as RootPresenterProtocol}
        
        container.register(.singleton) {
            LiveFeedInteractor() as LiveFeedInteractorProtocol
        }
        
        container.register(.singleton) {
            LoginInteractor() as LoginInteractorProtocol
        }
        
        container.register(.singleton) { RootInteractor() as RootInteractorProtocol }
            .resolvingProperties { (container, interactor) in
                var rootInteractor = interactor
                let presenter = try! container.resolve() as RootPresenterProtocol
                rootInteractor.presenter = presenter
        }
    }
}
