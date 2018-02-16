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
    
    var rootInteractor: RootInteractorProtocol!
    var appController: AppControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension RootViewController: RootDisplayProtocol {
    func showFeedView() {
        self.feedViewContainer.isHidden = false
        self.loginViewContainer.isHidden = true
    }
}

extension RootViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let keyword = textField.text else  {
            return true
        }
        rootInteractor.loadFeed(forKeyword: keyword)
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
