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
    var body: some View {
        PortalContainer {
            GeometryReader { geo in
                NavigationStack {
                    ScrollView {
                        LazyVStack {
                            let displayedCards: [Card] = MockData.cardData.filter { $0.title.lowercased().hasPrefix(self.viewModel.searchText.lowercased() ) }
                            
                            if !displayedCards.isEmpty {
                                ForEach(displayedCards) { card in
                                    Button {
                                        self.viewModel.showCardDetailView(for: card)
                                    } label: {
                                        CardCell(card: card)
                                            .portalSource(item: card)
                                    }.scaleButtonStyle()
                                }
                            } else {
                                ContentUnavailableView("No Results for \"\(self.viewModel.searchText)\"", systemImage: "magnifyingglass", description: Text("Try adjusting your search term or check the spelling. CardCraft only supports a search in the prefix of the card title."))
                            }
                        }.padding(.horizontal)
                    }
                    .prioritiseScaleButtonStyle()
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search for Cards"))
                    .navigationTitle("CardCraft")
                    .safeAreaInset(edge: .bottom, spacing: 20) {
                        createNewCardButton(geo: geo)
                    }
                    .ignoresSafeArea(edges: .bottom)
                }
                .sheet(item: $viewModel.selectedCard, onDismiss: viewModel.hideCardDetailView) { card in
                    CardDetailView(card: card)
                }
                .portalTransition(
                    item: $viewModel.selectedCard,
                    animation: .smooth(duration: 0.5, extraBounce: 0.1),
                    animationDuration: 0.5
                ) { card in
                    CardCell(card: card)
                }
            }
        }
    }
    
    func createNewCardButton(geo: GeometryProxy) -> some View {
        VStack {
            Button {
                
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
}
