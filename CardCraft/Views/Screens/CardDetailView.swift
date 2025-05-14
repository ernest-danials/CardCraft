//
//  CardDetailView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI
import Portal
import ErrorManager

struct CardDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var cardManager: CardManager
    @EnvironmentObject var errorManager: ErrorManager
    
    @State private var showingDeleteConfirmation = false
    let card: Card
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ScrollView {
                    VStack {
                        CardCell(card: card)
                            .portalDestination(item: card)
                        
                        Divider().padding(.vertical)
                        
                        VStack {
                            Text("Created on")
                                .customFont(size: 18, weight: .medium)
                                .foregroundStyle(.secondary)
                            
                            Text(self.card.creationDate.formatted(date: .abbreviated, time: .omitted))
                                .customFont(size: 20, weight: .bold, design: .rounded)
                        }
                        
                        Divider().padding(.vertical)
                        
                        VStack {
                            Text("Colours")
                                .customFont(size: 18, weight: .medium)
                                .foregroundStyle(.secondary)
                            
                            HStack(spacing: 12) {
                                ForEach(self.card.colors) { color in
                                    Circle()
                                        .fill(color.getColor())
                                        .frame(width: 70, height: 70)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 4)
                        }
                        
                        Divider().padding(.vertical)
                        
                        VStack {
                            Text("Message")
                                .customFont(size: 18, weight: .medium)
                                .foregroundStyle(.secondary)
                            
                            Text(self.card.message)
                                .customFont(size: 18, weight: .medium, design: .rounded)
                                .multilineTextAlignment(.center)
                        }
                        
                        Divider().padding(.vertical)
                        
                        VStack {
                            Text("Sound Effect")
                                .customFont(size: 18, weight: .medium)
                                .foregroundStyle(.secondary)
                            
                            Text(self.card.soundEffect?.rawValue ?? "No Sound Effect")
                                .customFont(size: 18, weight: .medium, design: .rounded)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .safeAreaPadding(.horizontal)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showingDeleteConfirmation = true
                            HapticManager.shared.notification(type: .warning)
                        } label: {
                            Image(systemName: "trash.fill")
                                .fontWeight(.medium)
                                .foregroundStyle(.red)
                        }
                        .confirmationDialog(
                            "Are you sure you want to delete this card?",
                            isPresented: $showingDeleteConfirmation,
                            titleVisibility: .visible
                        ) {
                            Button("Delete", role: .destructive) {
                                do {
                                    try cardManager.deleteCard(id: card.id)
                                    try cardManager.saveCards()
                                    viewModel.hideCardDetailView()
                                } catch {
                                    print("Error deleting card: \(error)")
                                    self.errorManager.showError(error as? CardManagerError ?? .unknownError)
                                }
                            }
                        } message: {
                            Text("This action cannot be undone.")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            self.viewModel.hideCardDetailView()
                        }
                        .fontWeight(.semibold)
                    }
                }
                .safeAreaInset(edge: .bottom, spacing: 25) {
                    VStack(spacing: 13) {
                        HStack {
                            NavigationLink {
                                ModifyCardView(editingCard: self.card, shouldShowCancelButton: false)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                                    .customFont(size: 18, weight: .semibold, design: .rounded)
                                    .clipped()
                                    .foregroundStyle(Color.accentColor)
                                    .frame(height: 25)
                                    .alignView(to: .center)
                                    .padding()
                                    .background(Material.ultraThin)
                                    .cornerRadius(17, corners: .allCorners)
                            }
                            .scaleButtonStyle()
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(style: .soft)
                            })
                            
                            ShareLink(
                                item: """
                                \(card.emoji) \(card.title)
                                
                                \(card.message)
                                
                                Shared from CardCraft
                                """
                            ) {
                                Label("Share", systemImage: "square.and.arrow.up")
                                    .customFont(size: 18, weight: .semibold, design: .rounded)
                                    .clipped()
                                    .foregroundStyle(Color.accentColor)
                                    .frame(height: 25)
                                    .alignView(to: .center)
                                    .padding()
                                    .background(Material.ultraThin)
                                    .cornerRadius(17, corners: .allCorners)
                            }
                            .scaleButtonStyle()
                            .simultaneousGesture(TapGesture().onEnded {
                                HapticManager.shared.impact(style: .soft)
                            })
                        }
                        
                        Button {
                            self.viewModel.showCardDisplayView()
                        } label: {
                            let backgroundColor: CardColor = card.colors.first ?? .blue
                            
                            Label("Display", systemImage: "giftcard.fill")
                                .customFont(size: 18, weight: .semibold, design: .rounded)
                                .clipped()
                                .foregroundStyle(backgroundColor.getTextColor())
                                .alignView(to: .center)
                                .padding()
                                .background(backgroundColor.getColor().gradient)
                                .cornerRadius(17, corners: .allCorners)
                        }.scaleButtonStyle()
                    }
                    .padding()
                    .padding(.bottom, geo.safeAreaInsets.bottom)
                    .background(Material.ultraThin)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                }
                .ignoresSafeArea(edges: .bottom)
            }
        }
    }
}

#Preview {
    CardDetailView(card: CardCollection.cardData[0])
        .environmentObject(ViewModel())
        .environmentObject(CrossModel())
        .environmentObject(CardManager())
        .environmentObject(ErrorManager())
}
