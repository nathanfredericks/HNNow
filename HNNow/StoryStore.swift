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

final class StoryStore: ObservableObject {
    var feedType: FeedType = .top {
        didSet {
            stories.removeAll()
            page = 0
            visibleRows = 0
            fetchStories(feed: feedType)
        }
    }
    
    @Published var stories = [Story]()
    @Published private(set) var isLoading = false

    private var visibleRows = 0
    private var page = 0
    
    func incrementVisibleRows() {
        visibleRows += 1
        
        // If there are 5 rows left, fetch more stories
        if stories.count - visibleRows == 5 {
            page += 1
            fetchStories(feed: feedType, page: page)
        }
    }
    
    func fetchStories(feed: FeedType, page: Int = 0) {
        let hackerNewsService = HackerNewsService()
        
        isLoading = true
        
        hackerNewsService.fetchStories(feed: feed, page: page) { (stories, error) in
            guard error == nil else {
                self.isLoading = false
                return
            }
            
            guard let stories = stories else {
                self.isLoading = false
                return
            }
            
            self.stories += stories
            self.isLoading = false
        }
    }
    
    init() {
        fetchStories(feed: feedType, page: page)
    }
}
