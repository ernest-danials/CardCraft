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
                    
                    Divider().padding(.vertical)
                    
                    
                }
                .padding(.horizontal)
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
        }
    }
}

#Preview {
    CardDetailView(card: MockData.cardData[0])
    .environmentObject(ViewModel())
    .environmentObject(CrossModel())
}
