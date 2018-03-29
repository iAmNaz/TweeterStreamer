//
//  TwitterAPITests.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import XCTest
@testable import TwitterFeedUI
@testable import TwitterKit

class MockTwitterClient: ClientProtocol {
    func twitterInstance() -> Twitter {
        return Twitter.sharedInstance()
    }
    
    func count() -> Int {
        return 0
    }
    
    func initializeClient() {
        
    }
    
    func creatRequest(endPoint: String) -> URLRequest {
        return URLRequest(url: URL(string: "https://google.com")!)
    }
}

class MockTwitterShared: NSObject, TwitterInstanceProtocol {
    var count = 0
    func logIn(completion: @escaping TWTRLogInCompletion) {
        completion(nil, nil)
    }
    
    func sessionCount() -> Int {
        return count
    }
    
    func instance() -> Twitter {
        return Twitter.sharedInstance()
    }
}

class TwitterAPITests: XCTestCase {

    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testReconnectWithKeywordResumtsDataTask() {
        let session = MockURLSession()
        let dataProcessor = TwitterDataProcessor()
        let api = MockTwitterAPI(dataProcessor: dataProcessor, client: MockTwitterClient())
        api.setupURLSession(session: session)
        api.appInteractor = AppInteractor(dataStore: MockDataStore(), router: AppSceneManager(), remoteAPI: api)
        api.reconnect(withKeyword: "keyword")
        XCTAssert(session.dataTask.hasResume == true)
    }
    
    func testAuthenticatedWithNonZeroSessionCountReturnsTrue() {
        let dataProcessor = TwitterDataProcessor()
        let twitterInstance = MockTwitterShared()
        twitterInstance.count = 1
        let thisApi = TwitterAPI(dataProcessor: dataProcessor, client: TwitterClient(twitterInstance: twitterInstance))
        thisApi.appInteractor = AppInteractor(dataStore: MockDataStore(), router: AppSceneManager(), remoteAPI: thisApi)
        XCTAssert(thisApi.authenticated() == true)
        
    }
}
