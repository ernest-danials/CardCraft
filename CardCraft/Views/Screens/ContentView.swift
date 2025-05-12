//
//  ContentView.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 100, maximum: 300)), .init(.adaptive(minimum: 100, maximum: 300)), .init(.adaptive(minimum: 100, maximum: 300))], spacing: 15) {
                    ForEach(MockData.cardData) { card in
                        Button {
                            
                        } label: {
                            CardCell(card: card)
                        }.scaleButtonStyle()
                    }
                }.padding(.horizontal)
            }
            .prioritiseScaleButtonStyle()
            .navigationTitle("CardCraft")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
