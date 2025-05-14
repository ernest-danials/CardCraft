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
    
    func loadCards() throws {
        let decoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoded = try decoder.decode([Card].self, from: data)
            self.cards = decoded
        } catch {
            print("Failed to load Cards: ", error)
            throw CardManagerError.couldNotDecode
        }
    }
    
    func saveCards() throws {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(cards)
            try data.write(to: fileURL)
            print("Cards successfully encoded and saved: \(data)")
        } catch {
            print("Failed to save Cards: ", error)
            throw CardManagerError.couldNotEncode
        }
    }
    
    func addCard(_ newCard: Card) {
        self.cards.append(newCard)
    }
    
    func deleteCard(id: String) throws {
        guard let index = self.cards.firstIndex(where: { $0.id == id }) else {
            throw error.cardNotFound
        }
        
        self.cards.remove(at: index)
    }
}

enum CardManagerError: LocalizedError {
    case cardNotFound, couldNotDecode, couldNotEncode, unknownError
    
    var localizedDescription: String? {
        switch self {
        case .cardNotFound:
            return "Could not find the card."
        case .couldNotDecode:
            return "Could not decode the saved card data."
        case .couldNotEncode:
            return "Could not encode the saved card data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
