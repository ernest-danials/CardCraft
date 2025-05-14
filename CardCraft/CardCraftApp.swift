//
//  CardCraftApp.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI
import ErrorManager

@main
struct CardCraftApp: App {
    @StateObject var viewModel = ViewModel()
    @StateObject var cardManager = CardManager()
    @StateObject var errorManager = ErrorManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(cardManager)
                .environmentObject(errorManager)
        }
    }
}
