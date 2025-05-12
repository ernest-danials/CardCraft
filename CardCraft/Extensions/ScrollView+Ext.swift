//
//  ScrollView+Ext.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-12.
//

import SwiftUI

extension ScrollView {
    func prioritiseScaleButtonStyle() -> some View {
        self.gesture(DragGesture(minimumDistance: 0), including: .all)
    }
}
