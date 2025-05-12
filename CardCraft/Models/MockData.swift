//
//  MockData.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import Foundation

struct MockData {
    static let cardData: [Card] = [
        Card(title: "Happy Mother's Day!", 
             emoji: "💐", 
             colors: [.pink, .purple, .indigo], 
             message: "To the most amazing mum in the world. Thank you for your endless love and support."),
        
        Card(title: "Happy Birthday!", 
             emoji: "🎂", 
             colors: [.yellow, .orange, .pink], 
             message: "Wishing you a fantastic birthday filled with joy and laughter!"),
        
        Card(title: "Congratulations!", 
             emoji: "🎉", 
             colors: [.mint, .teal, .blue], 
             message: "Well done on your amazing achievement! Here's to many more successes ahead."),
        
        Card(title: "Get Well Soon", 
             emoji: "🌸", 
             colors: [.pink, .purple, .blue], 
             message: "Sending you healing thoughts and warm wishes for a speedy recovery."),
        
        Card(title: "Thank You", 
             emoji: "🙏", 
             colors: [.mint, .green, .teal], 
             message: "Your kindness means the world to me. Thank you for everything you do."),
        
        Card(title: "Season's Greetings", 
             emoji: "⛄️", 
             colors: [.indigo, .purple, .blue], 
             message: "Wishing you and your loved ones a wonderful holiday season filled with warmth and joy.")
    ]
}
