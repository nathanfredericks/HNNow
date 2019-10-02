//
//  NetworkManager.swift
//  HNNow
//
//  Created by Rizwan on 02/10/19.
//  Copyright © 2019 Nathaniel Fredericks. All rights reserved.
//

import Foundation
import UIKit
import Network

class NetworkManager {
    private var monitor:NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private let alert: UIAlertController

    init() {
        monitor = NWPathMonitor()
        alert = UIAlertController(title: "Network Error", message: "Check your internet connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                print("No connection.")
                DispatchQueue.main.async {
                    if (!self.alert.isBeingPresented) {
                        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(self.alert, animated: true, completion: nil)
                        }
                    }
            }
        }
    }

    func startNotifier() {
        monitor.start(queue: queue)
    }

    func stopNotifier() {
        monitor.cancel()
    }
}
