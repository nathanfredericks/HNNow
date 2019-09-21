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
    private var shownRowCount = 0

    var body: some View {
        NavigationView {
            List {
                Picker("Feed type", selection: $store.feedType) {
                    ForEach(FeedType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                ForEach(store.stories) { story in
                    NavigationLink(destination: StoryWebView(story: story)) {
                        StoryRow(story: story)
                            .onAppear {
                                self.store.incrementVisibleRows()
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
