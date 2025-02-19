//
//  WatchConnectivityService.swift
//  CraveWatch
//
//  Created by [Your Name] on [Date].
//  Description: Manages WCSession for sending messages to the iPhone.
//               Publishes phone reachability status.
//

import Foundation
import WatchConnectivity

class WatchConnectivityService: NSObject, ObservableObject, WCSessionDelegate {
    
    @Published var phoneReachable: Bool = false
    private var session: WCSession?
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    // MARK: - Public
    
    /// Generic method to send any dictionary to the iPhone
    func sendMessageToPhone(_ message: [String: Any]) {
        guard let session = session, session.isReachable else {
            print("🔴 iPhone not reachable or session not available.")
            return
        }
        session.sendMessage(message, replyHandler: nil) { error in
            print("🔴 Failed to send message: \(error.localizedDescription)")
        }
    }
    
    /// Sends a WatchCravingEntity to the phone
    func sendCravingToPhone(craving: WatchCravingEntity) {
        let msg: [String: Any] = [
            "action": "logCraving",
            "description": craving.text,
            "intensity": craving.intensity,
            "timestamp": craving.timestamp.timeIntervalSince1970
        ]
        sendMessageToPhone(msg)
    }
    
    // MARK: - WCSessionDelegate
    
    nonisolated func session(_ session: WCSession,
                             activationDidCompleteWith activationState: WCSessionActivationState,
                             error: Error?) {
        Task { @MainActor in
            if let error = error {
                print("🔴 Session activation error: \(error.localizedDescription)")
            } else {
                print("✅ WatchConnectivity session activated. State: \(activationState.rawValue)")
            }
        }
    }
    
    nonisolated func sessionReachabilityDidChange(_ session: WCSession) {
        Task { @MainActor in
            self.phoneReachable = session.isReachable
            print("Reachability changed: \(session.isReachable)")
        }
    }
}
