//
//  PostRow.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

struct StoryRow : View {
    var story: Story

    var body: some View {
        VStack(alignment: .leading) {
            Text(story.title)
                .font(.headline)
                .lineLimit(2)
                .accessibility(label: Text(story.title))
            Text("\(story.score) points by \(story.by)")
                .font(.subheadline)
                .accessibility(label: Text("\(story.score) points by \(story.by)"))
        }
    }
}

#if DEBUG
struct StoryRow_Previews : PreviewProvider {
    static var previews: some View {
        StoryRow(story: testStories[0])
            .previewLayout(.sizeThatFits)
            .padding(.all)
    }
}
#endif
