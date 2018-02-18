//
//  TwitterAPI.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterAPI: NSObject, APIProtocol {
    fileprivate var dataProcessor: DataProcessorProtocol!
    
    var appInteractor: AppInteractorProtocol!
    
    fileprivate var defaultSession: URLSession! = nil
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate let consumerKey = "SBqYuEU4gNi0ejWeTbwGwGLbb"
    fileprivate let consumerSecret = "QkFrmvz4i1giK8vsFEkI6wwUcggsOCq3rUlzV8RQheN3O5Js64"
    
    fileprivate let streamAPIEndPoint = "https://stream.twitter.com/1.1/statuses/filter.json"
    fileprivate let sampleEndPoint = "https://stream.twitter.com/1.1/statuses/sample.json"
    fileprivate var session: TWTRSession?
    
    init(dataProcessor: TwitterDataProcessor) {
        super.init()
        self.dataProcessor = dataProcessor
        self.dataProcessor.delegate = self
        self.defaultSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }
    
    //MARK: - APIProtocol
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
      let filteredEndpoint = streamAPIEndPoint.appendTrackFilter(key: keyword)
        let request = creatRequest(endPoint: sampleEndPoint)
        print(request)
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    func disconnect() {
        dataTask?.cancel()
    }
    
    //MARK: - Private
    fileprivate func creatRequest(endPoint: String) -> URLRequest {
        let client = TWTRAPIClient.withCurrentUser()
        return client.urlRequest(withMethod: HTTPMethod.GET, url: endPoint, parameters: nil, error: nil)
    }
}

//MARK: - DataProcessorDelegate
extension TwitterAPI: DataProcessorDelegate {
    func didProcess(status: TweetStatus) {
        self.appInteractor.savePost(post: status.post())
    }
}

//MARK: - URLSessionDataDelegate
extension TwitterAPI: URLSessionDataDelegate, URLSessionDelegate{
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        DispatchQueue.main.async {
            self.dataProcessor.process(data: data)
        }
    }
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        appInteractor.didEndSession()
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        appInteractor.didFail(error: error)
    }
}

//MARK: - Helper
extension String {
    func appendTrackFilter(key: String) -> String {
        return self + "?track=" + key
    }
}

