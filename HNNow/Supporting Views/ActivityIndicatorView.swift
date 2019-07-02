//
//  ActivityIndicatorView.swift
//  HNNow
//
//  Created by Nathaniel Fredericks on 2019-06-11.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import SwiftUI

struct ActivityIndicatorView : UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.startAnimating()
    }
}

#if DEBUG
struct ActivityIndicatorView_Previews : PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView(style: .medium)
            .previewLayout(.sizeThatFits)
    }
}
#endif
