//
//  HackerNewsAPI.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation

struct HackerNewsService {
    /// Fetches story id's
    /// - Parameter feed: Feed type
    /// - Parameter completionHandler
    private func fetchStoryIds(feed: FeedType, completionHandler: @escaping ([Int]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://hacker-news.firebaseio.com/v0/\(feed.rawValue.lowercased())stories.json")!) { (data, _, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let ids = try decoder.decode([Int].self, from: data)
                
                completionHandler(ids, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
    
    /// Fetches and decodes story
    /// - Parameter id: Item ID
    /// - Parameter completionHandler
    private func fetchStory(id: Int, completionHandler: @escaping (Story?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://hacker-news.firebaseio.com/v0/item/\(id).json")!) { (data, _, error) in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let story = try decoder.decode(Story.self, from: data)
                
                completionHandler(story, nil)
            } catch {
                completionHandler(nil, error)
            }
        }.resume()
    }
    
//    /// Fetch's stories from feed
//    /// - Parameter feed: Feed type
//    /// - Parameter completionHandler
//    func fetchStories(feed: FeedType, completionHandler: @escaping ([Story]?, Error?) -> Void) {
//        fetchStoryIds(feed: feed) { (ids, error) in
//            guard error == nil else {
//                completionHandler(nil, error)
//                return
//            }
//
//            guard let ids = ids else {
//                completionHandler(nil, error)
//                return
//            }
//
//            let dispatchGroup = DispatchGroup()
//
//            var stories = [Story]()
//
//            for id in ids {
//                dispatchGroup.enter()
//
//                self.fetchStory(id: id) { (story, error) in
//                    guard error == nil else {
//                        dispatchGroup.leave()
//                        return
//                    }
//
//                    guard let story = story else {
//                        dispatchGroup.leave()
//                        return
//                    }
//
//                    stories.append(story)
//
//                    dispatchGroup.leave()
//                }
//            }
//
//            dispatchGroup.notify(queue: .main) {
//                completionHandler(stories, nil)
//            }
//        }
//    }
    
    func fetchStories(feed: FeedType, page: Int = 0, completionHandler: @escaping ([Story]?, Error?) -> Void) {
        let url = URL(string: "https://hnnow.nathfreder.workers.dev/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload = """
{
  "page": \(page)
}
""".data(using: .utf8)!
        
        URLSession.shared.uploadTask(with: request, from: payload) { (data, _, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil, nil)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let stories = try decoder.decode([Story].self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(stories, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }.resume()
    }
}
