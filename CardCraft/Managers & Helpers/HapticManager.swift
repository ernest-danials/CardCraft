//
//  HapticManager.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import UIKit

class HapticManager {
     static let shared = HapticManager()
    
    init() {}
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
