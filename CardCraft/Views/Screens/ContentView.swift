//
//  ContentView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI
import Portal

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    private let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 150, maximum: 200)), count: 2)
    var body: some View {
        PortalContainer {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(MockData.cardData) { card in
                            Button {
                                self.viewModel.showCardDetailView(for: card)
                            } label: {
                                CardCell(card: card)
                                    .portalSource(item: card)
                            }.scaleButtonStyle()
                        }
                    }.padding(.horizontal)
                }
                .prioritiseScaleButtonStyle()
                .navigationTitle("CardCraft")
            }
            .sheet(item: $viewModel.selectedCard, onDismiss: viewModel.hideCardDetailView) { card in
                CardDetailView(card: card)
            }
            .portalTransition(
                item: $viewModel.selectedCard,
                animation: .smooth(duration: 0.4, extraBounce: 0.1),
                animationDuration: 0.4
            ) { card in
                CardCell(card: card)
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
