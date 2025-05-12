//
//  ViewModel.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @Published var selectedCard: Card? = nil
    
    func showCardDetailView(for card: Card) {
        withAnimation(.spring) {
            self.selectedCard = card
        }
        
        HapticManager.shared.impact(style: .soft)
    }
    
    func hideCardDetailView() {
        withAnimation(.spring) {
            self.selectedCard = nil
        }
        
        HapticManager.shared.impact(style: .soft)
    }
}
