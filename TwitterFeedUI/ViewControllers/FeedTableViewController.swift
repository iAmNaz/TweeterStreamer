//
//  FeedTableViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, LiveFeedDisplayProtocol {
    func showLiveFeeds() {
        
    }
    
    func showAuthView() {
        
    }
    
    func reloadFeedView(feeds: [String]) {
        
    }
    
    func showPost(post: PostViewModelProtocol) {
        posts.insert(post, at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        if posts.count > 5 {
            posts.removeLast()
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 5, section: 0)], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    var appController: AppControllerProtocol!
    var containerView: ContainerViewDisplayProtocol!
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    var posts = [PostViewModelProtocol]()
    let cellIdentifier = "StatusCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liveFeedInteractor.startLiveFeed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FeedTableViewCell

        let post = posts[indexPath.row]
        
        cell.screenNameLabel.text = "@\(post.screenName)"
        cell.statusLabel.text = post.text
        cell.nameLabel.text = post.name
        if let imageURL = post.profileImageURL {
            cell.profileImgeView.kf.setImage(with: imageURL)
        }
        return cell
    }
}
