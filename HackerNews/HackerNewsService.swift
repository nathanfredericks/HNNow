//
//  HackerNewsAPI.swift
//  HackerNews
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation
import Alamofire

enum FeedType: String, CaseIterable {
    case top = "Top"
    case new = "New"
    case best = "Best"
}

struct HackerNewsService {
    /// Fetches story id's
    /// - Parameter feed: Feed type
    /// - Parameter completionHandler
    func fetchStoryIds(feed: FeedType, completionHandler: @escaping ([Int]?, Error?) -> Void) {
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
    func fetchStory(id: Int, completionHandler: @escaping (Story?, Error?) -> Void) {
        AF.request("https://hacker-news.firebaseio.com/v0/item/\(id).json").responseDecodable { (response: DataResponse<Story>) in
            switch response.result {
            case .success(let story):
                completionHandler(story, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
