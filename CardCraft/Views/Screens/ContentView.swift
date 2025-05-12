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
                    ForEach(0 ..< 5) { item in
                        VStack(spacing: 5) {
                            Text("🎉")
                                .customFont(size: 40)
                            
                            Text("Happy Mothers' Day!")
                                .customFont(size: 20, weight: .bold, design: .rounded)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.orange.gradient.opacity(0.3))
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.orange.opacity(0.5), lineWidth: 1)
                        }
                    }
                }.padding(.horizontal)
            }
            .navigationTitle("CardCraft")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
