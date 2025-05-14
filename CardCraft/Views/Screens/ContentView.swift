//
//  ContentView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI
import Portal
import ErrorManager

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var cardManager: CardManager
    @EnvironmentObject var errorManager: ErrorManager
    var body: some View {
        PortalContainer {
            GeometryReader { geo in
                NavigationStack {
                    ScrollView {
                        LazyVStack {
                            let displayedCards: [Card] = self.cardManager.cards.filter { $0.title.lowercased().hasPrefix(self.viewModel.searchText.lowercased() ) }.sorted { $0.creationDate > $1.creationDate }
                            
                            if !displayedCards.isEmpty {
                                ForEach(displayedCards) { card in
                                    Button {
                                        self.viewModel.showCardDetailView(for: card)
                                    } label: {
                                        CardCell(card: card)
                                            .portalSource(item: card)
                                    }.scaleButtonStyle()
                                }
                            } else if !self.viewModel.searchText.isEmpty {
                                ContentUnavailableView("No Results for \"\(self.viewModel.searchText)\"", systemImage: "magnifyingglass", description: Text("Try adjusting your search term or check the spelling. CardCraft only supports a search in the prefix of the card title."))
                            } else {
                                ContentUnavailableView("You Have No Cards Yet", systemImage: "rectangle.stack.badge.plus", description: Text("Tap the 'Create a New Card' button below to get started with your first card"))
                            }
                        }.padding()
                    }
                    .prioritiseScaleButtonStyle()
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search for Cards"))
                    .navigationTitle("CardCraft")
                    .safeAreaInset(edge: .bottom, spacing: 20) {
                        createNewCardButton(geo: geo)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .fullScreenCover(item: $viewModel.selectedCard) { card in
                    CardDetailView(card: card)
                        .overlay {
                            if self.viewModel.isShowingCardDisPlayView {
                                CardDisplayView()
                            }
                        }
                }
                .sheet(isPresented: $viewModel.isShowingCreateCardView, onDismiss: viewModel.hideCreateCardView) {
                    NavigationStack {
                        ModifyCardView(editingCard: nil)
                    }
                }
                .portalTransition(
                    item: $viewModel.selectedCard,
                    animation: .smooth(duration: 0.5, extraBounce: 0.1),
                    animationDuration: 0.5
                ) { card in
                    CardCell(card: card)
                }
            }.task {
                do {
                    try self.cardManager.loadCards()
                } catch {
                    self.errorManager.showError(error as? CardManagerError ?? .unknownError)
                }
            }
        }
    }
    
    func createNewCardButton(geo: GeometryProxy) -> some View {
        VStack {
            Button {
                self.viewModel.showCreateCardView()
            } label: {
                Text("Create a New Card")
                    .customFont(size: 18, weight: .bold, design: .rounded)
                    .foregroundStyle(.white)
                    .clipped()
                    .alignView(to: .center)
                    .padding()
                    .background(Color.accentColor.gradient)
                    .cornerRadius(16, corners: .allCorners)
            }.scaleButtonStyle()
        }
        .padding()
        .padding(.bottom, geo.safeAreaInsets.bottom)
        .background(Material.ultraThin)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .environmentObject(ErrorManager())
        .environmentObject(CardManager())
        .environmentObject(CrossModel())
}
