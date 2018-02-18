//
//  IncomingDataProcessor.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 15/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

protocol DataProcessorProtocol {
    var delegate: DataProcessorDelegate? { get set }
    func process(data: Data)
}

protocol DataProcessorDelegate {
    func didProcess(status: TweetStatus)
}

class TwitterDataProcessor: DataProcessorProtocol {
    var delegate: DataProcessorDelegate?
    fileprivate let formatter = DateFormatter()
    fileprivate let jsonDecoder = JSONDecoder()
    fileprivate var dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
    
    init() {
        formatter.dateFormat = self.dateFormat
        jsonDecoder.dateDecodingStrategy = .formatted(formatter)
    }
    
    func process(data: Data)  {
        guard let tweetStatus = try? jsonDecoder.decode(TweetStatus.self, from: data) else{
            return
        }
        delegate?.didProcess(status: tweetStatus)
    }
}
