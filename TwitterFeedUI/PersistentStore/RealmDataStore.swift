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
    let dataStoreQueue = DispatchQueue(label: "Realm Data Store Queue")
    let realm = try! Realm()
    
    func deletePost(withId id: String) {
        guard let post = realm.object(ofType: TweetStatusModel.self, forPrimaryKey: id) else {
            return
        }
        
        try! realm.write {
            realm.delete(post)
        }
    }
    
    func fetchRecent() -> Post? {
        let posts = realm.objects(TweetStatusModel.self)
        let sortedPosts = posts.sorted(byKeyPath: "timeStamp", ascending: false)
        
        if sortedPosts.count > 0 {
            return sortedPosts.first?.post()
        }
        return nil
    }
    
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
    
    func insert(post: PostProtocol) {
        
        let cachedPost = realm.object(ofType: TweetStatusModel.self, forPrimaryKey: post.id)
        
        //Prevent posting the same post
        if cachedPost != nil {
            return
        }
        
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
            
            self.delegate?.didInsert(post: tweet.post()!)
        }
    }
    
    func truncate() {
        try! realm.write {
            let all = realm.objects(TweetUserModel.self)
            realm.delete(all)
        }
    }
}
