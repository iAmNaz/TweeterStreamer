//
//  Tweet.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

struct TweetStatus: Codable {
    var dateCreated: Date
    var id: String
    var text: String
    var user: TweetUser
    
    enum CodingKeys: String, CodingKey
    {
        case dateCreated = "created_at"
        case id = "id_str"
        case text
        case user
    }
    
    func post() -> PostProtocol {
        let user = PostedBy(id: self.user.id, name: self.user.name, screenName: self.user.screenName, url: self.user.url, profileImage: self.user.profileImage)
        return Post(dateCreated: self.dateCreated, id: self.id, text: self.text, postedBy: user)
    }

}

extension TweetStatus: CustomStringConvertible {
    var description: String {
        return "dateCreated: \(dateCreated)\ntext: \(text)\nuser: \(user)"
    }
}
