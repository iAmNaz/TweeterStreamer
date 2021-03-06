//
//  AppDelegate.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import Dip
import Dip_UI
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appController: AppControllerProtocol!
    let container = DependencyContainer()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupDIP()
        appController = try! container.resolve() as AppControllerProtocol
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if Twitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        
        return false
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appController.didBecomeActive()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appController.sentToBackground()
    }
}

