//
//  WatchCravingEntity.swift
//  CraveWatch
//
//  Created by [Your Name] on [Date].
//  Description: A SwiftData model representing a craving on the watch side.
//
import Foundation
import SwiftData

@Model
public class WatchCravingEntity {
    // SwiftData automatically provides an internal ID, so no need for a custom id property.
    
    public var text: String
    public var intensity: Int
    public var timestamp: Date
    
    public init(text: String, intensity: Int, timestamp: Date = Date()) {
        self.text = text
        self.intensity = intensity
        self.timestamp = timestamp
    }
}
