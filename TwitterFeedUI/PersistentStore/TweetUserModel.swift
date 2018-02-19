//
//  TweetUserModel.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 17/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//
import RealmSwift

/**
 Represents a twitter user status
*/
class TweetUserModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String!
    @objc dynamic var screenName: String!
    @objc dynamic var location: String!
    @objc dynamic var url: String!
    @objc dynamic var profileImage: String!
}
