//
//  CardPreviewStatic.swift
//  CardCraft
//
//  Created by Assistant on 2025-05-13.
//

import SwiftUI

struct CardPreview: View {
    @Binding var emoji: String
    @Binding var title: String
    @Binding var message: String
    let colors: [Color]
    
    private let points: [SIMD2<Float>] = [
        [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
        [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
        [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
    ]
    
    var body: some View {
        ZStack {
            let expandedColors = ColorManager.expandColors(colors)
            
            MeshGradient(width: 3, height: 3, points: points, colors: expandedColors, smoothsColors: true)
            
            VStack(spacing: 10) {
                Text(emoji)
                    .customFont(size: 65)
                    .minimumScaleFactor(0.6)
                    .clipped()
                
                Text(title)
                    .customFont(size: 30, weight: .heavy, design: .rounded)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .clipped()
                
                Text(message)
                    .customFont(size: 20, weight: .medium, design: .rounded)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5)
                    .clipped()
            }
            .padding(30)
        }
    }
} 
