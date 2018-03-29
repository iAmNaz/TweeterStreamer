//
//  TwitterClient.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 21/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

protocol ClientProtocol {
    func initializeClient()
    func creatRequest(endPoint: String) -> URLRequest
    func twitterInstance() -> Twitter
    func count() -> Int
}

class TwitterClient: ClientProtocol {
    fileprivate let consumerKey = "SBqYuEU4gNi0ejWeTbwGwGLbb"
    fileprivate let consumerSecret = "QkFrmvz4i1giK8vsFEkI6wwUcggsOCq3rUlzV8RQheN3O5Js64"
    
    fileprivate var twitter: TwitterInstanceProtocol
    
    init(twitterInstance: TwitterInstanceProtocol) {
        self.twitter = twitterInstance
    }
    
    func initializeClient() {
        twitter.instance().start(withConsumerKey:consumerKey, consumerSecret:consumerSecret)
    }
    
    func creatRequest(endPoint: String) -> URLRequest {
        let client = TWTRAPIClient.withCurrentUser()
        return client.urlRequest(withMethod: HTTPMethod.GET, url: endPoint, parameters: nil, error: nil)
    }
    
    func twitterInstance() -> Twitter {
        return twitter.instance()
    }
    
    func count() -> Int {
        return twitter.sessionCount()
    }
}
