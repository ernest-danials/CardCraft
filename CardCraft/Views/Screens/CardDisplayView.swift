//
//  CardDisplayView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-13.
//

import SwiftUI
import ErrorManager

struct CardDisplayView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject var errorManager: ErrorManager
    
    @State private var points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
    ]
    @State private var isShowingInstructions: Bool = true
    
    var body: some View {
        ZStack {
            if let card = self.viewModel.selectedCard {
                ZStack {
                    let originalColors = card.colors.map { $0.getColor() }
                    let expandedColors = ColorManager.expandColors(originalColors)
                    
                    MeshGradient(width: 3, height: 3, points: points, colors: expandedColors, smoothsColors: true)
                    
                    VStack(spacing: 10) {
                        Spacer()
                        
                        Text(card.emoji)
                            .customFont(size: 65)
                            .clipped()
                        
                        Text(card.title)
                            .customFont(size: 30, weight: .heavy, design: .rounded)
                            .multilineTextAlignment(.center)
                            .clipped()
                        
                        Text(card.message)
                            .customFont(size: 20, weight: .medium, design: .rounded)
                            .multilineTextAlignment(.center)
                            .clipped()
                        
                        Spacer()
                        
                        if isShowingInstructions {
                            var instructionText: String {
                                if card.soundEffect == nil {
                                    return "Double tap to close."
                                } else {
                                    return "Double tap to close. Triple tap to play the sound effect."
                                }
                            }
                            
                            Text(instructionText)
                                .customFont(size: 17, weight: .medium, design: .rounded)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.secondary)
                                .transition(.blurReplace)
                        }
                    }
                    .padding(30)
                }
            } else {
                ContentUnavailableView("Error", systemImage: "exclamationmark.triangle.fill", description: Text("An error has occurred while displaying the card. (selectedCard is nil.) Tap anywhere to dismiss."))
                    .padding()
                    .background()
                    .onTapGesture(perform: self.viewModel.hideCardDisplayView)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            startTimer()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.spring) { self.isShowingInstructions = false }
            }
        }
        .onTapGesture {
            withAnimation(.spring) { self.isShowingInstructions = true }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.spring) { self.isShowingInstructions = false }
            }
        }
        .onTapGesture(count: 2, perform: viewModel.hideCardDisplayView)
        .onTapGesture(count: 3) {
            do {
                if let card = self.viewModel.selectedCard, let soundEffect = card.soundEffect {
                    try SoundEffectManager.shared.playSoundEffect(soundEffect)
                }
            } catch {
                self.errorManager.showError(error as? SoundEffectManagerError ?? .unknownError)
            }
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 2)) {
                // Only animate the centre point (index 4)
                points[4] = [Float.random(in: 0.2...0.9), Float.random(in: 0.2...0.9)]
            }
        }
    }
}

#Preview {
    CardDisplayView()
        .environmentObject(ViewModel())
        .environmentObject(ErrorManager())
}
