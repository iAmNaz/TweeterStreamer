//
//  DIFactory.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

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
            
            let api = TwitterAPI(dataProcessor: dataProcessor)
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

