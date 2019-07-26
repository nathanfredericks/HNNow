//
//  ContentView.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-09.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

enum FeedType: String, CaseIterable {
    case top = "Top"
    case new = "New"
    case best = "Best"
}

struct ContentView : View {
    @ObjectBinding var store = StoryStore()
    
    var body: some View {
        NavigationView {
            List {
                SegmentedControl(selection: $store.feedType) {
                    ForEach(FeedType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                
                ForEach(store.stories) { story in
                    NavigationLink(destination: StoryWebView(story: story)) {
                        StoryRow(story: story)
                    }
                }
                }
                .navigationBarTitle(Text("HN Now"))
                .navigationBarItems(trailing: Button(action: {
                    guard !self.store.isLoading else { return }
                    
                    self.store.fetchStories(feed: self.$store.feedType.value)
                }) {
                    if store.isLoading {
                        ActivityIndicatorView(style: .medium)
                    } else {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.blue)
                            .accessibility(label: Text("Reload"))
                    }
                    }
            )
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
