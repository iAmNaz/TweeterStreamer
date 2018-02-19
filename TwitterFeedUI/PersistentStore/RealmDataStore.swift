//
//  RealmDataStore.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import RealmSwift

enum PostFields {
    static let timeStamp = "timeStamp"
    static let id = "id"
}

/**
Concrete data store using Realm
*/
class RealmDataStore: NSObject, DataStoreProtocol {
    
    var delegate: DataStoreDelegate?
    let dataStoreQueue = DispatchQueue(label: "Realm Data Store Queue")
    let realm = try! Realm()
    
    func deletePost(withId id: String) {
        guard let post = realm.object(ofType: TweetStatusModel.self, forPrimaryKey: id) else {
            return
        }
        
        let user = post.user
        try! realm.write {
            realm.delete(post)
            realm.delete(user!)
        }
    }
    
    func fetchRecent() -> Post? {
        let posts = realm.objects(TweetStatusModel.self)
        let sortedPosts = posts.sorted(byKeyPath: PostFields.timeStamp, ascending: false)
        
        guard let tweet = sortedPosts.first else {
            return nil
        }
        return tweet.post()
    }
    
    
    func fetchPost(withId id: String) -> Post? {
        let posts = realm.objects(TweetStatusModel.self).filter("\(PostFields.id) = '\(id)'")
        let post = posts.first?.post()
        return post
    }
    
    func insert(post: PostProtocol) {
        
        //Prevent posting the same post
        let cachedPost = realm.object(ofType: TweetStatusModel.self, forPrimaryKey: post.id)

        if cachedPost != nil {
            return
        }
        
        //Insert transaction
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
            //Optional
            self.delegate?.didInsert(post: tweet.post()!)
        }
    }
    
    //Remove all objects from datastore. Soon they will be outdated
    func truncate() {
        try! realm.write {
            let all = realm.objects(TweetUserModel.self)
            realm.delete(all)
        }
    }
}
