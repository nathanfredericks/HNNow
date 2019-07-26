//
//  StoryStore.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class StoryStore: BindableObject {
    var willChange = PassthroughSubject<StoryStore, Never>()
    
    var feedType: FeedType = .top {
        didSet {
            stories.removeAll()
            fetchStories(feed: feedType)
        }
    }
    
    var stories = [Story]() {
        didSet { willChange.send(self) }
    }
    
    private(set) var isLoading: Bool = false {
        didSet { willChange.send(self) }
    }
    
    func fetchStories(feed: FeedType) {
        let hackerNewsService = HackerNewsService()
        
        isLoading = true
        
        hackerNewsService.fetchStories(feed: feed) { (stories, error) in
            guard error == nil else {
                self.isLoading = false
                return
            }
            
            guard let stories = stories else {
                self.isLoading = false
                return
            }
            
            self.stories = stories
            self.isLoading = false
        }
    }
    
    init() {
        fetchStories(feed: feedType)
    }
}
