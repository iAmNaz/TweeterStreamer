//
//  DetailViewControllerTest.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 29/03/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import XCTest
@testable import TwitterFeedUI

class DetailViewControllerTest: XCTestCase {
    let tScreenName = "screename"
    let tName = "name"
    let tStatus = "status"
    var detailVC: DetailViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let post = PostViewModel(id: "id", screenName: tScreenName , name: tName, text: tStatus, profileImageString: nil, dateCreated: "null")
        
        detailVC.post = post
        
        let _ = detailVC.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDisplaysPostOnViewDidLoad() {
        XCTAssert(detailVC.nameLabel.text! == tName)
        XCTAssert(detailVC.screenNameLabel.text! == "@\(tScreenName)")
        XCTAssert(detailVC.statusLabel.text! == tStatus)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
