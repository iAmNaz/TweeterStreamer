//
//  RealmDataStore.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import RealmSwift

class RealmDataStore: NSObject, DataStoreProtocol {
    var delegate: DataStoreDelegate?
    
    func fetchPosts(timeStamp: Int) -> Post? {
        let posts = realm.objects(TweetStatusModel.self).filter("timeStamp > \(timeStamp)")
        let sortedPosts = posts.sorted(byKeyPath: "timeStamp", ascending: false)
        return sortedPosts.first?.post()
    }
    
    func fetchPost(withId id: String) -> Post? {
        let posts = realm.objects(TweetStatusModel.self).filter("id = '\(id)'")
        let post = posts.first?.post()
        return post
    }
    
    let dataStoreQueue = DispatchQueue(label: "Realm Data Store Queue")
    let realm = try! Realm()
    
    func insert(post: PostProtocol) {
            let user = TweetUserModel()
            user.id = post.postedBy.id
            user.name = post.postedBy.name
            user.screenName = post.postedBy.screenName
            user.url = post.postedBy.url
            user.profileImage = post.postedBy.profileImage
        
            let tweet = TweetStatusModel()
            tweet.dateCreated = post.dateCreated
            tweet.id = post.id
            tweet.text = post.text
            tweet.user = user
            tweet.timeStamp = Int(Date().timeIntervalSince1970)
        
            try! realm.write {
                realm.add(tweet)
                
                self.delegate?.didInsert(post: tweet.post())
            }
    }
    
    func fetchLatest() {
        
    }
    
    
}
