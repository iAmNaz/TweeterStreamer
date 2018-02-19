//
//  DetailViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 18/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var liveFeedInteractor: LiveFeedInteractorProtocol!
    var post: PostViewModelProtocol!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = post.name
        self.screenNameLabel.text = "@\(post.screenName)"
        self.statusLabel.text = post.text
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Actions
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true) {
            self.liveFeedInteractor.resumeLiveFeed()
        }
    }
}
