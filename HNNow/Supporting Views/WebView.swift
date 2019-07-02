//
//  WebView.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-11.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView : UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

#if DEBUG
struct WebView_Previews : PreviewProvider {
    static var previews: some View {
        WebView(request: URLRequest(url: URL(string: "https://news.ycombinator.com/")!))
    }
}
#endif
