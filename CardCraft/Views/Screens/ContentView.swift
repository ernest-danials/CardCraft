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
                
            }
            .navigationTitle("CardCraft")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
}
