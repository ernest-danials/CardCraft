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
    let creationDate: Date
    
    init(id: String = UUID().uuidString, title: String, emoji: String, colors: [CardColor], message: String, creationDate: Date) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.colors = colors
        self.message = message
        self.creationDate = creationDate
    }
}

enum CardColor: Codable {
    case red
    case green
    case orange
    case blue
    case purple
    case pink
    case teal
    case yellow
    case indigo
    case mint
    
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
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .teal:
            return .teal
        case .yellow:
            return .yellow
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        }
    }
}
