//
//  Story.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

struct Story: Identifiable, Decodable {
    let id: Int
    let by: String
    let score: Int
    let title: String
    let url: URL?
}

#if DEBUG
let testStories = [
    Story(id: 8863, by: "dhouston", score: 111, title: "My YC app: Dropbox - Throw away your USB drive", url: URL(string: "http://www.getdropbox.com/u/2/screencast.html")),
    Story(id: 121003, by: "tel", score: 25, title: "Ask HN: The Arc Effect", url: nil)
]
#endif

