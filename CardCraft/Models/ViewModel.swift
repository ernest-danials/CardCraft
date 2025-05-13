//
//  ViewModel.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

final class ViewModel: ObservableObject {
    // MARK: - Selected Card
    @Published var selectedCard: Card? = nil
    
    func showCardDetailView(for card: Card) {
        withAnimation(.spring) {
            self.selectedCard = card
        }
        
        HapticManager.shared.impact(style: .soft)
    }
    
    func hideCardDetailView() {
        guard self.selectedCard != nil else { return }
        
        withAnimation(.spring) {
            self.selectedCard = nil
        }
        
        HapticManager.shared.impact(style: .soft)
    }
    
    // MARK: - Search
    @Published var searchText: String = ""
}
