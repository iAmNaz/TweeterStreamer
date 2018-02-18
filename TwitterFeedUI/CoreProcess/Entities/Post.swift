//
//  UserStatus.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 17/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

protocol PostProtocol {
    var dateCreated: Date { get set }
    var id: String { get set }
    var text: String { get set }
    var postedBy: PostedBy { get set }
}

struct Post: PostProtocol {
    var dateCreated: Date
    var id: String
    var text: String
    var postedBy: PostedBy
}
