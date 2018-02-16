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
    var location: String
    var url: URL
    var description: String
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case name
        case screenName = "screen_name"
        case location
        case url
        case description
    }
}
