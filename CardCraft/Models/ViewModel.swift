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
            self.isShowingCardDisPlayView = false
        }
        
        HapticManager.shared.impact(style: .soft)
    }
    
    // MARK: - ContentView Search
    @Published var searchText: String = ""
    
    // MARK: - CardDisplayView
    @Published var isShowingCardDisPlayView: Bool = false
    
    func showCardDisplayView() {
        withAnimation(.spring) {
            self.isShowingCardDisPlayView = true
            HapticManager.shared.impact(style: .soft)
        }
    }
    
    func hideCardDisplayView() {
        guard self.isShowingCardDisPlayView else { return }
        
        withAnimation(.spring) {
            self.isShowingCardDisPlayView = false
            HapticManager.shared.impact(style: .soft)
        }
    }
    
    // MARK: - CreateCardView
    @Published var isShowingCreateCardView: Bool = false
    
    func showCreateCardView() {
        withAnimation(.spring) {
            self.isShowingCreateCardView = true
            HapticManager.shared.impact(style: .soft)
        }
    }
    
    func hideCreateCardView() {
        guard self.isShowingCreateCardView else { return }
        
        withAnimation(.spring) {
            self.isShowingCreateCardView = false
            HapticManager.shared.impact(style: .soft)
        }
    }
    
    // MARK: - Collection
    @Published var isShowingCollectionView: Bool = false
    
    func showCollectionView() {
        withAnimation(.spring) {
            self.isShowingCollectionView = true
            HapticManager.shared.impact(style: .soft)
        }
    }
    
    func hideCollectionView() {
        guard self.isShowingCollectionView else { return }
        
        withAnimation(.spring) {
            self.isShowingCollectionView = false
            HapticManager.shared.impact(style: .soft)
        }
    }
}
