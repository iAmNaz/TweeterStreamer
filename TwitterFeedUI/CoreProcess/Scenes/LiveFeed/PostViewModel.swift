//
//  PostViewModelProtocol.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 18/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

/**
    View level presentation of a post
 */
struct PostViewModel: PostViewModelProtocol {
    var id: String
    var screenName: String
    var name: String
    var text: String
    var profileImageURL: URL? {
        get {
            if let url = profileImageString {
                return URL(string: url)
            }
            return nil
        }
    }
    var profileImageString: String?
    var dateCreated: String
}
