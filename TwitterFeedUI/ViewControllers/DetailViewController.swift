//
//  DetailViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 18/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    var post: PostViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayPost()
    }
    
    // MARK: - Private
    func displayPost() {
        self.nameLabel.text = post.name
        self.screenNameLabel.text = "@\(post.screenName)"
        self.statusLabel.text = post.text
    }
    
    // MARK: - Actions
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true) {
            self.liveFeedInteractor.resumeLiveFeed()
        }
    }
}
