//
//  DIFactory.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 16/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import Foundation

protocol DependencyFactoryProtocol {
    func remoteAPI(dataProcessor: TwitterDataProcessor) -> APIProtocol
    func dataStore () -> DataStoreProtocol
}

struct DependencyFactory: DependencyFactoryProtocol {
    var env = Configuration.sharedInstance.environment
    
    func remoteAPI(dataProcessor: TwitterDataProcessor) -> APIProtocol {
        if env == Environment.Live {
            let api = TwitterAPI(dataProcessor: dataProcessor)
            return api
        }
        return FakeTwitterAPI(dataProcessor: dataProcessor)
    }
    
    func dataStore() -> DataStoreProtocol {
        return RealmDataStore()
    }
}

