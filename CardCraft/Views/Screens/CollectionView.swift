//
//  CollectionView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-14.
//

import SwiftUI
import ErrorManager

struct CollectionView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var cardManager: CardManager
    @EnvironmentObject var errorManager: ErrorManager
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Tap to save the card.")
                    .customFont(size: 18, weight: .medium, design: .rounded)
                    .alignView(to: .leading)
                    .padding()
                    .background(Material.ultraThin)
                    .cornerRadius(17, corners: .allCorners)
                
                ForEach(CardCollection.cardData) { card in
                    let doesExistAlready = self.cardManager.cards.contains(where: { $0.id == card.id })
                    
                    Button {
                        if doesExistAlready {
                            HapticManager.shared.impact(style: .rigid)
                        } else {
                            do {
                                self.cardManager.addCard(card)
                                try self.cardManager.saveCards()
                            } catch {
                                self.errorManager.showError(error as? CardManagerError ?? .unknownError)
                            }
                            
                            self.viewModel.hideCollectionView()
                            HapticManager.shared.impact(style: .soft)
                        }
                    } label: {
                        CardCell(card: card)
                            .opacity(doesExistAlready ? 0.5 : 1.0)
                    }.scaleButtonStyle(scaleAmount: doesExistAlready ? 0.99 : 0.98)
                }
            }
            .prioritiseScaleButtonStyle()
            .safeAreaPadding([.horizontal, .bottom])
            .navigationTitle("Collection")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        self.viewModel.hideCollectionView()
                    }.fontWeight(.medium)
                }
            }
        }
    }
}

#Preview {
    CollectionView()
        .environmentObject(ViewModel())
        .environmentObject(CardManager())
        .environmentObject(ErrorManager())
}
