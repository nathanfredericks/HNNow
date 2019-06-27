//
//  StoryStore.swift
//  HackerNews
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class StoryStore: BindableObject {
    var didChange = PassthroughSubject<StoryStore, Never>()
    
    var feedType: FeedType = .top {
        didSet {
            stories.removeAll()
            fetchStories(feed: feedType)
        }
    }
    
    var stories = [Story]() {
        didSet { didChange.send(self) }
    }
    
    private(set) var isLoading: Bool = false {
        didSet { didChange.send(self) }
    }
    
    func fetchStories(feed: FeedType) {
        let hackerNewsService = HackerNewsService()
        
        isLoading = true
        
        hackerNewsService.fetchStoryIds(feed: feed) { (ids, error) in
            guard error == nil else {
                self.isLoading = false
                return
            }
            
            guard let ids = ids else {
                self.isLoading = false
                return
            }
            
            for id in ids {
                hackerNewsService.fetchStory(id: id) { (story, error) in
                    guard error == nil else {
                        return
                    }
                    
                    guard let story = story else {
                        return
                    }
                    
                    self.stories.append(story)
                }
            }
            
           self.isLoading = false
        }
    }
    
    init() {
        fetchStories(feed: feedType)
    }
}
