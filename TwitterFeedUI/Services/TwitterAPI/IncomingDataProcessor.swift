//
//  IncomingDataProcessor.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

protocol IncomingDataProcessorProtocol {
    func process(data: Data)
    var dateFormat: String! { set get }
}

class IncomingDataProcessor {
    let formatter = DateFormatter()
    let jsonDecoder = JSONDecoder()
    var dateFormat: String!
    
    init() {
        formatter.dateFormat = dateFormat
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
    }
    
    func process(data: Data) {
        guard let tweetStatus = try? jsonDecoder.decode(TweetStatus.self, from: data) else{
            return
        }
        
        print("name: \(tweetStatus.user.screenName)")
        print("date: \(tweetStatus.dateCreated)")
    }
}
