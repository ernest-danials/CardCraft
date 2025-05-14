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
    let soundEffect: SoundEffect?
    let creationDate: Date
    
    init(id: String = UUID().uuidString, title: String, emoji: String, colors: [CardColor], message: String, soundEffect: SoundEffect?, creationDate: Date) {
        self.id = id
        self.title = title
        self.emoji = emoji
        self.colors = colors
        self.message = message
        self.soundEffect = soundEffect
        self.creationDate = creationDate
    }
}

enum CardColor: Identifiable, Codable, CaseIterable {
    case red, green, orange, blue, purple, pink, teal, yellow, indigo, mint
    
    var id: Self { self }
    
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
    
    func getTextColor() -> Color {
        switch self {
        case .red, .blue, .purple, .pink, .indigo:
            return .white
        case .green, .orange, .teal, .yellow, .mint:
            return .black
        }
    }
}
