//
//  CardCell.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

struct CardCell: View {
    let card: Card
    var body: some View {
        VStack(spacing: 5) {
            Text(card.emoji)
                .customFont(size: 40)
            
            Text(card.title)
                .customFont(size: 20, weight: .bold, design: .rounded)
                .multilineTextAlignment(.center)
                .fixedSize()
        }
        .alignView(to: .center)
        .alignViewVertically(to: .center)
        .padding()
        .background {
            let color = card.colors.first?.getColor() ?? Color.orange
            RoundedRectangle(cornerRadius: 20)
                //.fill(color.gradient.opacity(0.3))
                .fill(color.gradient.secondary)
        }
        .overlay {
            let color = card.colors.first?.getColor() ?? Color.orange
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(color.opacity(0.5), lineWidth: 1)
        }
    }
}
