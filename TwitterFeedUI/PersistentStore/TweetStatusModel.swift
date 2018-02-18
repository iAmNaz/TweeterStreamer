//
//  TweetStatusModel.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 17/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import RealmSwift

class TweetStatusModel: Object {
    @objc dynamic var dateCreated: Date!
    @objc dynamic var id: String!
    @objc dynamic var text: String!
    @objc dynamic var user: TweetUserModel!
    @objc dynamic var timeStamp = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func post() -> Post? {
        if dateCreated == nil {
            return nil
        }
        
        let user = PostedBy(id: self.user.id, name: self.user.name, screenName: self.user.screenName, url: self.user.url, profileImage: self.user.profileImage)
        return Post(dateCreated: dateCreated, id: id, text: text, postedBy: user)
    }
}
