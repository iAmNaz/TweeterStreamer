//
//  FeedTableViewController.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewController: UITableViewController {
    
    var appController: AppControllerProtocol!
    var liveFeedInteractor: LiveFeedInteractorProtocol!
    
    fileprivate var posts: [PostViewModelProtocol]!
    fileprivate let cellIdentifier = "StatusCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        posts = [PostViewModelProtocol]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private
    fileprivate func removeOldPost(post: PostViewModelProtocol) {
        if posts.count > 5 {
            let post = posts.removeLast()
            tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: 5, section: 0)], with: .automatic)
            tableView.endUpdates()
            removeCachedImage(withKey: post.id)
        }
    }
    
    fileprivate func broadcastPostWasAdded(post: PostViewModelProtocol) {
        liveFeedInteractor.postDisplayed(id: post.id)
    }
    
    fileprivate func insertNewPost(post: PostViewModelProtocol) {
        posts.insert(post, at: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    fileprivate func removeCachedImage(withKey key: String){
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
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StatusDetail" {
            if let viewController = segue.destination as? DetailViewController {
                let selectedIndexpath = tableView.indexPathForSelectedRow
                let post = posts[(selectedIndexpath?.row)!]
                viewController.post = post
            }
        }
    }
}

extension FeedTableViewController: LiveFeedDisplayProtocol {
    func showPost(post: PostViewModelProtocol) {
        insertNewPost(post: post)
        broadcastPostWasAdded(post: post)
        removeOldPost(post: post)
    }
    
    func showEmptyFeed() {
        posts = [PostViewModelProtocol]()
        tableView.reloadData()
    }
}
