//
//  TweetUser.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation


struct TweetUser: Codable {
    var id: Int
    var name: String
    var screenName: String
    var url: String
    var profileImage: String 
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case screenName = "screen_name"
        case url
        case profileImage = "profile_image_url_https"
    }
}

extension TweetUser: CustomStringConvertible {
    var description: String {
        return "name: \(name)\nscreenName: \(screenName)\nprofileImage: \(profileImage)"
    }
}
