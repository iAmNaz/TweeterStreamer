//
//  AppInteractor+DataStore.swift
//  TwitterFeedUI
//
//  Created by Nazario Mariano on 19/02/2018.
//  Copyright © 2018 Nazario Mariano. All rights reserved.
//

extension AppInteractor {
    func savePost(post: PostProtocol) {
        dataStore().insert(post: post)
    }
    
    func fetch(withId id: String) -> Post? {
        return dataStore().fetchPost(withId: id)
    }
    
    func removePost(withId id: String) {
        dataStore().deletePost(withId: id)
    }
    
    func fetchRecentPost() {
        guard let post = dataStore().fetchRecent() else {
            return
        }
        
        rootInteractor.hasFinishedConnecting()
        if !realTimeFeed {
            liveFeedInteractor.pushFeed(withId: post.id)
        }
    }
    
    func emptyPersistentStore() {
        liveFeedInteractor.clearFeeds()
        dataStore().truncate()
    }
}
