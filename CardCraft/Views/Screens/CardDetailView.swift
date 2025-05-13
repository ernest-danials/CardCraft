//
//  CardDetailView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI
import Portal

struct CardDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
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
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 12) {
                                    ForEach(self.card.colors) { color in
                                        Circle()
                                            .fill(color.getColor())
                                            .containerRelativeFrame(.horizontal, count: 4, spacing: 12)
                                    }
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal, 4)
                                .scrollTargetLayout()
                            }
                            .scrollIndicators(.hidden)
                            .scrollTargetBehavior(.viewAligned)
                            .contentMargins(.horizontal, 10, for: .scrollContent)
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
                    }
                    .safeAreaPadding(.horizontal)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            self.viewModel.hideCardDetailView()
                        }
                        .fontWeight(.semibold)
                    }
                }
                .safeAreaInset(edge: .bottom, spacing: 15) {
                    VStack(spacing: 13) {
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Edit")
                                    .customFont(size: 18, weight: .semibold, design: .rounded)
                                    .clipped()
                                    .foregroundStyle(Color.accentColor)
                                    .alignView(to: .center)
                                    .padding()
                                    .background(Material.ultraThin)
                                    .cornerRadius(17, corners: .allCorners)
                            }.scaleButtonStyle()
                            
                            Button {
                                
                            } label: {
                                Text("Share")
                                    .customFont(size: 18, weight: .semibold, design: .rounded)
                                    .clipped()
                                    .foregroundStyle(Color.accentColor)
                                    .alignView(to: .center)
                                    .padding()
                                    .background(Material.ultraThin)
                                    .cornerRadius(17, corners: .allCorners)
                            }.scaleButtonStyle()
                        }
                        
                        Button {
                            
                        } label: {
                            Text("Display")
                                .customFont(size: 18, weight: .semibold, design: .rounded)
                                .clipped()
                                .foregroundStyle(.white)
                                .alignView(to: .center)
                                .padding()
                                .background(Color.accentColor.gradient)
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
    CardDetailView(card: MockData.cardData[0])
    .environmentObject(ViewModel())
    .environmentObject(CrossModel())
}
