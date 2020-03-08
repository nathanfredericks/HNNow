//
//  HackerNewsService.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation

struct HackerNewsService {
    /// Fetch's stories from feed
    /// - Parameter feed: Feed type
    /// - Parameter page: Page number
    /// - Parameter completionHandler
    func fetchStories(feed: FeedType, page: Int = 0, completionHandler: @escaping ([Story]?, Error?) -> Void) {
        let url = URL(string: "https://hnnow.nathfreder.workers.dev/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let payload = """
{
  "feed": "\(feed.rawValue.lowercased())",
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
                decoder.dateDecodingStrategy = .secondsSince1970
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
