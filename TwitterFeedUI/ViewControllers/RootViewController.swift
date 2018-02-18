//
//  ViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

enum ContainerView {
    case LoginView
    case FeedView
}

protocol FeedItemViewModel {
    var profileImageURL: URL { get set }
    var screenName: String { get set }
    var text: String { get set }
}

protocol ContainerViewDisplayProtocol {
    func hide(view: ContainerView)
    func show(view: ContainerView)
}

class RootViewController: UIViewController {

    @IBOutlet weak var keywordTextField: UITextField!
    @IBOutlet weak var feedViewContainer: UIView!
    @IBOutlet weak var loginViewContainer: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var rootInteractor: RootInteractorProtocol!
    var appController: AppControllerProtocol!
    
    fileprivate var currentKeyword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appController.didLaunch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate func keywordEntered(keyword: String){
        currentKeyword = keyword
        rootInteractor.loadFeed(forKeyword: currentKeyword!)
    }
}

extension RootViewController: RootDisplayProtocol {
    func showAuthView() {
        statusLabel.isHidden = true
        loginViewContainer.isHidden = false
        feedViewContainer.isHidden = true
        navigationBar.isHidden = true
    }
    
    func showFeedView() {
        keywordTextField.isHidden = false
        loginViewContainer.isHidden = true
        navigationBar.isHidden = false
        keywordTextField.becomeFirstResponder()
        feedViewContainer.isHidden = false
    }
    
    func showFeedView(withModels: [String]) {
        feedViewContainer.isHidden = false
    }
    
    func showLoadingFeeds() {
        statusLabel.isHidden = false
        statusLabel.text = "loading feeds..."
    }
}

extension RootViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField.text?.isEmpty)!  {
            return false
        }
        let lowerCased = textField.text!.lowercased()
        view.endEditing(true)
        keywordEntered(keyword: lowerCased)
        return true
    }
}

extension RootViewController: ContainerViewDisplayProtocol {
    func hide(view: ContainerView) {
        if view == .FeedView {
            feedViewContainer.isHidden = true
        }else{
            loginViewContainer.isHidden = true
        }
    }
    
    func show(view: ContainerView) {
        if view == .LoginView {
            feedViewContainer.isHidden = false
        }else{
            loginViewContainer.isHidden = false
        }
    }
}
