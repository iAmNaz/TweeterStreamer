//
//  LiveFeedPresenter.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//
import Foundation

protocol PostViewModelProtocol {
    var id: String { get set }
    var screenName: String { get set }
    var name: String { get set }
    var text: String { get set }
    var profileImageURL: URL? { get }
    var dateCreated: String { get set }
}

protocol LiveFeedDisplayProtocol {
    func showPost(post: PostViewModelProtocol)
    func showEmptyFeed()
}

protocol LiveFeedPresenterProtocol {
    func presentPost(post: Post)
    func presentEmptyFeed()
}

class LiveFeedPresenter: LiveFeedPresenterProtocol {
    var viewController: LiveFeedDisplayProtocol!
    fileprivate let formatter = DateFormatter()
    fileprivate var dateFormat = "MMM dd"
    
    init() {
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale.current
    }
    
    func presentPost(post: Post) {
        
        let postVM = PostViewModel(id: "\(post.id)", screenName: post.postedBy.screenName, name: post.postedBy.name, text: post.text, profileImageString: post.postedBy.profileImage, dateCreated: formatter.string(from: post.dateCreated))
        
        viewController.showPost(post: postVM)
    }
    
    func presentEmptyFeed() {
        viewController.showEmptyFeed()
    }
}
