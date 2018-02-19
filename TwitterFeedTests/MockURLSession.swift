//
//  MockURLSession.swift
//  TwitterFeedTests
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit

class MockDataTask: URLSessionDataTask {
    var hasResume = false
    var wasCancelled = false
    
    override func resume() {
        hasResume = true
    }
    
    override func cancel() {
        wasCancelled = true
    }
}

class MockURLSession: URLSession {
    var dataTask: MockDataTask!
    override func dataTask(with request: URLRequest) -> URLSessionDataTask {
        dataTask = MockDataTask()
        return dataTask
    }
}
