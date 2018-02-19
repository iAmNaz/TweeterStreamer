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

class RootViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var feedViewContainer: UIView!
    @IBOutlet weak var loginViewContainer: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var rootInteractor: RootInteractorProtocol!
    var appController: AppControllerProtocol!
    var appInteractor: AppInteractorProtocol!
    
    fileprivate var currentKeyword: String?
    fileprivate var searchActive : Bool = false
    
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
    
    @IBAction func logoutAction(_ sender: Any) {
        loggedOutView()
        appInteractor.logout()
    }
    
    //MARK - Private
    fileprivate func keywordEntered(keyword: String){
        currentKeyword = keyword
        rootInteractor.loadFeed(forKeyword: currentKeyword!)
    }
    
    fileprivate func displayStatus(message: String) {
        statusLabel.isHidden = false
        view.bringSubview(toFront: statusLabel)
        statusLabel.text = message
    }
    
    fileprivate func loggedInView() {
        hideStatus()
        loginViewContainer.isHidden = true
        feedViewContainer.isHidden = false
        logoutButton.isHidden = false
        searchBar.isHidden = false
    }
    
    fileprivate func loggedOutView() {
        logoutButton.isHidden = true
        statusLabel.isHidden = true
        searchBar.isHidden = true
        feedViewContainer.isHidden = true
        loginViewContainer.isHidden = false
        searchBar.endEditing(true)
    }
}

extension RootViewController: RootDisplayProtocol {

    func show(message: String) {
        displayStatus(message: message)
    }
    
    func showProgress() {
        displayStatus(message: "loading...")
    }
    
    func hideStatus() {
        statusLabel.isHidden = true
    }
    
    func showAuthRequiredView() {
        loggedOutView()
    }
    
    //Called after auth or if authorized
    func showFeedView() {
        loggedInView()
    }
    
    func showKeyword(keyword: String) {
        searchBar.text = keyword
    }
}

extension RootViewController: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = currentKeyword
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //dismiss keyboard
        self.searchBar.endEditing(true)
        
        //prevent empty text
        if (searchBar.text?.isEmpty)!  {
            searchBar.text = currentKeyword
            return
        }
        
        let lowerCased = searchBar.text!.lowercased()
        currentKeyword = lowerCased
        keywordEntered(keyword: lowerCased)
    }
}
