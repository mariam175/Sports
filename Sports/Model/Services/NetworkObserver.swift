//
//  NetworkObserver.swift
//  Sports
//
//  Created by Macos on 22/05/2025.
//''''

import Foundation
import Reachability
class NetworkObserver {
    private var reachability: Reachability?
    weak var delegate: NetworkStatusDelegate?

    init(delegate: NetworkStatusDelegate?) {
        self.delegate = delegate
        setupReachability()
    }

    private func setupReachability() {
        do {
            reachability = try Reachability()
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(reachabilityChanged),
                name: .reachabilityChanged,
                object: nil
            )

            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc private func reachabilityChanged(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        let isConnected = reachability.connection != .unavailable
        delegate?.networkStatusChanged(isConnected: isConnected)
    }

    func isConnectedToInternet() -> Bool {
        return reachability?.connection != .unavailable
    }
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
