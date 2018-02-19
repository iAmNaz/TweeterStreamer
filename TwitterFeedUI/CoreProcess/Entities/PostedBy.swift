//
//  PostAuthor.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 17/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

protocol PostedByProtocol {
    var id: Int { get set }
    var name: String { get set }
    var screenName: String { get set }
    var url: String? { get set }
    var profileImage: String? { get set }
}

struct PostedBy: PostedByProtocol {
    var id: Int
    var name: String
    var screenName: String
    var url: String?
    var profileImage: String?
    init(id: Int, name: String, screenName: String, url: String?, profileImage: String?) {
        self.id = id
        self.name = name
        self.screenName = screenName
        self.url = url == nil ? "" : url
        self.profileImage = profileImage == nil ? "" : profileImage!
    }
}
