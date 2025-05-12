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
        NavigationStack {
            ScrollView {
                VStack {
                    CardCell(card: card)
                        .portalDestination(item: card)
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        self.viewModel.hideCardDetailView()
                    }
                }
            }
        }
    }
}

#Preview {
    CardDetailView(card: Card(
        title: "Birthday Wishes",
        emoji: "🎂",
        colors: [.blue, .purple, .pink],
        message: "Wishing you a fantastic birthday filled with joy and laughter! May all your dreams come true."
    ))
    .environmentObject(ViewModel())
}
