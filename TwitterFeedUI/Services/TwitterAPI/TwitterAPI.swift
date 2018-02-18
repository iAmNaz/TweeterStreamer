//
//  TwitterAPI.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterAPI: NSObject, APIProtocol, URLSessionDelegate, URLSessionDataDelegate {
    var appInteractor: AppInteractorProtocol!

    var incomingDataProcessor: IncomingDataProcessor!
    
    fileprivate var defaultSession: URLSession! = nil
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate let consumerKey = "SBqYuEU4gNi0ejWeTbwGwGLbb"
    fileprivate let consumerSecret = "QkFrmvz4i1giK8vsFEkI6wwUcggsOCq3rUlzV8RQheN3O5Js64"
    
//    fileprivate let streamAPIEndPoint = "https://stream.twitter.com/1.1/statuses/filter.json"
    fileprivate let streamAPIEndPoint = "https://stream.twitter.com/1.1/statuses/sample.json"
    fileprivate var session: TWTRSession?
    
    init(dataProcessor: IncomingDataProcessor) {
        super.init()
        self.incomingDataProcessor = dataProcessor
        self.defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func initializeService() {
        Twitter.sharedInstance().start(withConsumerKey:consumerKey, consumerSecret:consumerSecret)
    }
    
    func authenticateClient(completionBlk: @escaping (Error?) -> ()) {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                self.session = session
            }
            completionBlk(error)
        })
    }
    
    func authenticated() -> Bool {
        let store = Twitter.sharedInstance().sessionStore
        return store.session() != nil && store.session()?.authToken != nil
    }
    
    func reconnect(withKeyword keyword: String) {
//        if error.domain == TWTRAPIErrorDomain && (error.code == .InvalidOrExpiredToken || error.code == .BadGuestToken) {
//            
//        }
//        dataTask?.cancel()
        let filteredEndpoint = streamAPIEndPoint.appendTrackFilter(key: keyword)
        let request = creatRequest(endPoint: streamAPIEndPoint)
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    func disconnect() {
        dataTask?.cancel()
    }
    
    fileprivate func creatRequest(endPoint: String) -> URLRequest {
        let client = TWTRAPIClient.withCurrentUser()
        
        return client.urlRequest(withMethod: HTTPMethod.GET, url: endPoint, parameters: nil, error: nil)
    }
}

extension TwitterAPI {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        appInteractor.didEndSession()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        print(json)
//        incomingDataProcessor.process(data: data)
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        appInteractor.didFail(error: error)
    }
}

extension String {
    func appendTrackFilter(key: String) -> String {
        return self + "?track=" + key
    }
}
