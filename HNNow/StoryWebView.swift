//
//  StoryWebView.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-11.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

struct StoryWebView : View {
    var story: Story
    
    var body: some View {
        WebView(request: URLRequest(url: story.url!))
            .navigationBarItems(trailing: Button(action: {
                UIApplication.shared.open(self.story.url!)
            }) {
                Image(systemName: "safari")
                    .foregroundColor(.blue)
                    .accessibility(label: Text("Open in Safari"))
                }
        ).navigationBarTitle("", displayMode: .inline)
    }
}

#if DEBUG
struct StoryWebView_Previews : PreviewProvider {
    static var previews: some View {
        StoryWebView(story: testStories[0])
    }
}
#endif
