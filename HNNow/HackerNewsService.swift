//
//  HackerNewsAPI.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation
import Alamofire

struct HackerNewsService {
    /// Fetches story id's
    /// - Parameter feed: Feed type
    /// - Parameter completionHandler
    private func fetchStoryIds(feed: FeedType, completionHandler: @escaping ([Int]?, Error?) -> Void) {
        AF.request("https://hacker-news.firebaseio.com/v0/\(feed.rawValue.lowercased())stories.json").responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let ids = data as? [Int] else { return }
                completionHandler(ids, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    /// Fetches and decodes story
    /// - Parameter id: Item ID
    /// - Parameter completionHandler
    private func fetchStory(id: Int, completionHandler: @escaping (Story?, Error?) -> Void) {
        AF.request("https://hacker-news.firebaseio.com/v0/item/\(id).json").responseDecodable { (response: DataResponse<Story>) in
            switch response.result {
            case .success(let story):
                completionHandler(story, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    /// Fetch's stories from feed
    /// - Parameter feed: Feed type
    /// - Parameter completionHandler
    func fetchStories(feed: FeedType, completionHandler: @escaping ([Story]?, Error?) -> Void) {
        fetchStoryIds(feed: feed) { (ids, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            guard let ids = ids else {
                completionHandler(nil, error)
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            var stories = [Story]()
            
            for id in ids {
                dispatchGroup.enter()
                
                self.fetchStory(id: id) { (story, error) in
                    guard error == nil else {
                        dispatchGroup.leave()
                        return
                    }
                    
                    guard let story = story else {
                        dispatchGroup.leave()
                        return
                    }
                    
                    stories.append(story)
                    
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completionHandler(stories, nil)
            }
        }
    }
}
