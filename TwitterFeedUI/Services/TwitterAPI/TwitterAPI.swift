//
//  TwitterAPI.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterAPI: NSObject, APIProtocol, URLSessionDelegate {
    
    var appInteractor: AppInteractorProtocol!
    var incomingDataProcessor: IncomingDataProcessor!
    
    fileprivate var defaultSession: URLSession! = nil
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate let consumerKey = "SBqYuEU4gNi0ejWeTbwGwGLbb"
    fileprivate let consumerSecret = "QkFrmvz4i1giK8vsFEkI6wwUcggsOCq3rUlzV8RQheN3O5Js64"
    
    fileprivate let streamAPIEndPoint = "https://stream.twitter.com/1.1/statuses/filter.json"
    fileprivate var session: TWTRSession?
    
    override init() {
        super.init()
        self.defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    func initializeService() {
        Twitter.sharedInstance().start(withConsumerKey:consumerKey, consumerSecret:consumerSecret)
    }
    
    func authenticateClient() {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if (session != nil) {
                self.session = session
                self.appInteractor.didAuthenticate()
            } else {
                self.appInteractor.didFailAuthentication(error: error!)
            }
        })
    }
    
    func authenticated() -> Bool {
        return session != nil && session?.authToken != nil
    }
    
    func reconnect(withKeyword keyword: String) {
        dataTask?.cancel()
        let filteredEndpoint = streamAPIEndPoint.appendTrackFilter(key: keyword)
        let request = creatRequest(endPoint: filteredEndpoint)
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
        incomingDataProcessor.process(data: data)
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
