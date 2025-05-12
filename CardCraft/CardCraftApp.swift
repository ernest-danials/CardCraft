//
//  CardCraftApp.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

@main
struct CardCraftApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
        }
    }
}
