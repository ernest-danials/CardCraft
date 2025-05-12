//
//  Card.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

struct Card: Identifiable, Codable {
    let id: String
    let title: String
    let emoji: String
    let colors: [CardColor]
    let message: String
}

enum CardColor: Codable {
    case red
    case green
    case orange
    case blue
    
    func getColor() -> Color {
        switch self {
        case .red:
            return .red
        case .green:
            return .green
        case .orange:
            return .orange
        case .blue:
            return .blue
        }
    }
}
