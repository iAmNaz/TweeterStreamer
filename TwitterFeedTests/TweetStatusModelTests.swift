//
//  TweetStatusModelTests.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import XCTest

@testable import TwitterFeedUI

class TweetStatusModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPostMethodReturnsCorrecIntanceValues() {
        let stat = TweetStatusModel()
        let user = TweetUserModel()
        user.id = 1
        user.name = "me"
        user.screenName = "screen"
        user.profileImage = "https://mysite.com/profile.jpg"
        user.location = "location"
        
        stat.dateCreated = Date()
        stat.id = "12345"
        stat.text = "some text"
        stat.user = user
        
        let post = stat.post()
        
        XCTAssert(stat.dateCreated == post!.dateCreated)
        XCTAssert(stat.id == post!.id)
        XCTAssert(stat.text == post!.text)
        XCTAssert(stat.user.id == post!.postedBy.id)
        XCTAssert(stat.user.profileImage == post!.postedBy.profileImage)
    }
}
