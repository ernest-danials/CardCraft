//
//  CardCell.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

struct CardCell: View {
    @Environment(\.colorScheme) var colorScheme
    let card: Card
    var body: some View {
        VStack(spacing: 5) {
            Text(card.emoji)
                .customFont(size: 40)
            
            Text(card.title)
                .customFont(size: 20, weight: .bold, design: .rounded)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .fixedSize()
        }
        .alignView(to: .center)
        .alignViewVertically(to: .center)
        .padding()
        .background {
            let color = card.colors.first?.getColor() ?? Color.orange
            RoundedRectangle(cornerRadius: 20)
                .fill(color.mix(with: .black, by: colorScheme == .dark ? 0.25 : 0.1).gradient)
        }
        .overlay {
            let color = card.colors.first?.getColor() ?? Color.orange
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(color.opacity(0.5), lineWidth: 1)
        }
    }
}
