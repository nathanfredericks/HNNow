//
//  Story.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

struct Story: Identifiable, Decodable, Equatable {
    let id: Int
    let by: String
    let score: Int
    let title: String
    let url: URL?
    let time: Date
    
    static func ==(lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
}

#if DEBUG
let testStories = [
    Story(id: 8863, by: "dhouston", score: 111, title: "My YC app: Dropbox - Throw away your USB drive", url: URL(string: "http://www.getdropbox.com/u/2/screencast.html"), time: Date()),
    Story(id: 121003, by: "tel", score: 25, title: "Ask HN: The Arc Effect", url: nil, time: Date())
]
#endif

