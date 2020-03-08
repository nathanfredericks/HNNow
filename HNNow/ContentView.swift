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
    @ObservedObject var store = StoryStore()

    var body: some View {
        NavigationView {
            List {
                Picker("Feed type", selection: $store.feedType) {
                    ForEach(FeedType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                        .accessibility(label: Text("Select \(type.rawValue)"))
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                ForEach(store.stories) { story in
                    NavigationLink(destination: StoryWebView(story: story)) {
                        StoryRow(story: story)
                            .onAppear {
                                let index = self.store.stories.firstIndex(of: story)!
                                guard index == (self.store.stories.count - 6) else { return }
                                
                                self.store.page += 1
                                self.store.fetchStories(feed: self.store.feedType, page: self.store.page)
                            }
                    }
                }
            }
            .navigationBarTitle(Text("HN Now"))
            .navigationBarItems(trailing: Button(action: {
                guard !self.store.isLoading else { return }
                
                self.store.fetchStories(feed: self.$store.feedType.wrappedValue)
            }) {
                if store.isLoading {
                    ActivityIndicatorView(style: .medium)
                }
            })
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
