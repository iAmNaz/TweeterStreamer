//
//  LoginViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var loginInteractor: LoginInteractorProtocol!
    var containerView: ContainerViewDisplayProtocol!
    var appController: AppControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        appController.pauseFeed()
    }
    
    // MARK: - Actions
    @IBAction func loginAction(_ sender: Any) {
        loginInteractor.authenticate()
    }
}


extension LoginViewController: LoginDisplayProtocol {
    func showLoginView() {
        containerView?.show(view: .LoginView)
    }
    
    func hideLoginView() {
        containerView?.hide(view: .LoginView)
    }
}
