//
//  DIFactory.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

protocol DependencyFactoryProtocol {
    func remoteAPI () -> APIProtocol
    func dataStore () -> DataStoreProtocol
}

struct DependencyFactory: DependencyFactoryProtocol {
    
    func remoteAPI() -> APIProtocol {
        let twitterDateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let incomingDataProcessor = IncomingDataProcessor()
        incomingDataProcessor.dateFormat = twitterDateFormat
        let api = TwitterAPI()
            api.incomingDataProcessor = IncomingDataProcessor()
        
        return api
//        if env == Environment.Dev {
//            return FakeTwitterAPI()
//        }else{
//            return TwitterAPI()
//        }
    }
    
    func dataStore() -> DataStoreProtocol {
        return RealmDataStore()
    }
}

