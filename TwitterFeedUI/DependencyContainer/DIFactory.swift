//
//  DIFactory.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation
import TwitterKit

/**
 Generate the appropriate instance, service for a given environment
*/
protocol DependencyFactoryProtocol {
    func remoteAPI(dataProcessor: TwitterDataProcessor) -> APIProtocol
    func dataStore () -> DataStoreProtocol
}

struct DependencyFactory: DependencyFactoryProtocol {
    var env = Configuration.sharedInstance.environment
    
    func remoteAPI(dataProcessor: TwitterDataProcessor) -> APIProtocol {
        if env == Environment.Live {
            let twitterInstance = TwitterShared(twitter: Twitter.sharedInstance())
            let api = TwitterAPI(dataProcessor: dataProcessor, client: TwitterClient(twitterInstance: twitterInstance))
            let urlSession = URLSession(configuration: .default, delegate: api, delegateQueue: nil)
            api.setupURLSession(session: urlSession)
            return api
        }
        return FakeTwitterAPI(dataProcessor: dataProcessor)
    }
    
    func dataStore() -> DataStoreProtocol {
        return RealmDataStore()
    }
}

