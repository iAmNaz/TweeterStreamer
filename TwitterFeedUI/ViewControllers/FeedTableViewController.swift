//
//  FeedTableViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewController: UITableViewController, LiveFeedDisplayProtocol {
    var appController: AppControllerProtocol!
    var containerView: ContainerViewDisplayProtocol!
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    var posts = [PostViewModelProtocol]()
    let cellIdentifier = "StatusCell"
    
    func showPost(post: PostViewModelProtocol) {
        posts.insert(post, at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        liveFeedInteractor.postDisplayed(id: post.id)
        
        if posts.count > 5 {
            let post = posts.removeLast()
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 5, section: 0)], with: .automatic)
            tableView.endUpdates()
            removeCachedImage(withKey: post.id)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private
    func removeCachedImage(withKey key: String){
        ImageCache.default.removeImage(forKey: key)
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
            let resource = ImageResource(downloadURL: imageURL, cacheKey: post.id)
            cell.profileImgeView.kf.setImage(with: resource)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        liveFeedInteractor.stopFeeds()
    }
}
