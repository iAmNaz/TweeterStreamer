//
//  TwitterAPITests.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import XCTest
@testable import TwitterFeedUI

class TwitterAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDataTaskResumeOnReconnect() {
        let session = MockURLSession()
        let dataProcessor = TwitterDataProcessor()
        let api = MockTwitterAPI(dataProcessor: dataProcessor)
        api.setupURLSession(session: session)
        api.appInteractor = AppInteractor(dataStore: MockDataStore(), router: AppSceneManager(), remoteAPI: api)
        api.reconnect(withKeyword: "keyword")
        XCTAssert(session.dataTask.hasResume == true)
    }
}
