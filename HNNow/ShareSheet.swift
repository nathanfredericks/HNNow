//
//  ShareSheet.swift
//  HNNow
//
//  Created by Abbas Mousavi on 10/1/19.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import UIKit
import SwiftUI

struct ActivityViewController : UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    var url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        
        return UIActivityViewController(activityItems: [url], applicationActivities: [])
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {

    }
}
