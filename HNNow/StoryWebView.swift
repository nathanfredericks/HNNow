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
    @State private var showSheet = false
    
    var body: some View {
        WebView(request: URLRequest(url: story.url ?? URL(string: "https://google.com")!))
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        UIApplication.shared.open(self.story.url!)
                    }) {
                        Image(systemName: "safari")
                            .foregroundColor(.blue)
                            .accessibility(label: Text("Open in Safari"))
                    }
                    
                    Button(action: {
                        self.showSheet = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                            .accessibility(label: Text("Share story"))
                    }.sheet(isPresented: $showSheet) {
                        ActivityViewController(url: self.story.url!)
                    }
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
