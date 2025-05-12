//
//  CardManager.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import Foundation

final class CardManager: ObservableObject {
    private typealias error = CardManagerError
    
    @Published var cards: [Card] = []
    
    private var fileURL: URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("cards.json")
    }
    
    required init() { loadCards() }
    
    func loadCards() {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try decoder.decode([Card].self, from: data)
            self.cards = decoded
        } catch {
            print("Failed to load Cards: ", error)
        }
    }
    
    func saveCards() {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(cards)
            try data.write(to: fileURL)
            print("Cards successfully encoded and saved: \(data)")
        } catch {
            print("Failed to save Cards: ", error)
        }
    }
    
    func addCard(_ newCard: Card) {
        self.cards.append(newCard)
        saveCards()
    }
    
    func deleteCard(id: String) throws {
        guard let index = self.cards.firstIndex(where: { $0.id == id }) else {
            throw error.cardNotFound
        }
        
        self.cards.remove(at: index)
        saveCards()
    }
}

enum CardManagerError: Error {
    case cardNotFound
}
