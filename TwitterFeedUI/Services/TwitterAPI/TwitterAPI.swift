//
//  TwitterAPI.swift
//  TwitterFeed
//
//  Created by Nazario Mariano on 14/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

import UIKit
import TwitterKit
import Reachability

enum HTTPMethod {
    static let GET = "GET"
    static let POST = "POST"
}

class TwitterAPI: NSObject, APIProtocol {
    
    var appInteractor: AppInteractorProtocol!
    var session: TWTRSession?
    
    fileprivate var dataProcessor: DataProcessorProtocol!
    fileprivate let reachability = Reachability()!
    fileprivate var defaultSession: URLSession! = nil
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate let consumerKey = "SBqYuEU4gNi0ejWeTbwGwGLbb"
    fileprivate let consumerSecret = "QkFrmvz4i1giK8vsFEkI6wwUcggsOCq3rUlzV8RQheN3O5Js64"
    fileprivate let streamAPIEndPoint = "https://stream.twitter.com/1.1/statuses/filter.json"
    fileprivate let sampleEndPoint = "https://stream.twitter.com/1.1/statuses/sample.json"
    
    init(dataProcessor: TwitterDataProcessor) {
        super.init()
        setupDataProcessor(dataProcessor: dataProcessor)
        monitorReachability()
    }
    
    //MARK: - APIProtocol
    func initializeService() {
        Twitter.sharedInstance().start(withConsumerKey:consumerKey, consumerSecret:consumerSecret)
    }
    
    func reconnect(withKeyword keyword: String) {
        let filteredEndpoint = assembleEndPoint(forKeyword: keyword)
    
        let request = creatRequest(endPoint: filteredEndpoint)
        print(request)
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
    
    //MARK: - Private
    fileprivate func assembleEndPoint(forKeyword keyword: String) -> String {
        let allowedCharacters = NSCharacterSet.urlFragmentAllowed
        let encodedString = keyword.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        let filteredEndpoint = streamAPIEndPoint.appendTrackFilter(key: encodedString!)
        return filteredEndpoint
    }
    
    func setupURLSession(session: URLSession) {
        self.defaultSession = session
    }
    
    fileprivate func setupDataProcessor(dataProcessor: TwitterDataProcessor) {
        self.dataProcessor = dataProcessor
        self.dataProcessor.delegate = self
    }
    
    fileprivate func monitorReachability() {
        reachability.whenReachable = { reachability in
            self.appInteractor.resumeStream()
        }
        
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.appInteractor.didFail(error: APIError.noConnectionError)
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
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
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if reachability.connection == .none {
            DispatchQueue.main.async {
                self.appInteractor.didFail(error: APIError.noConnectionError)
            }
        }
    }
}

//MARK: - Helper
extension String {
    func appendTrackFilter(key: String) -> String {
        return self + "?track=" + key
    }
}
