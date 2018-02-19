//
//  TweetStatusModel.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 17/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import RealmSwift

/**
 Represents a twitter status
 */
class TweetStatusModel: Object {
    @objc dynamic var dateCreated: Date!
    @objc dynamic var id: String!
    @objc dynamic var text: String!
    @objc dynamic var user: TweetUserModel!
    @objc dynamic var timeStamp = 0
    
    override static func primaryKey() -> String? {
        return PostFields.id
    }
    
    //Helper method that generates a post object
    func post() -> Post? {
        if self.user == nil {
            return nil
        }
        
        let postUser = PostedBy(id: self.user.id, name: self.user.name, screenName: self.user.screenName, url: self.user.url, profileImage: self.user.profileImage)
        return Post(dateCreated: dateCreated, id: id, text: text, postedBy: postUser)
    }
}
