//
//  ColorManager.swift
//  CardCraft
//
//  Created by Myung Joon Kang on 2025-05-13.
//

import SwiftUI

struct ColorManager {
    static func expandColors(_ colors: [Color]) -> [Color] {
        guard !colors.isEmpty else { return [] }
        
        var expandedColors: [Color] = []
        let originalCount = colors.count
        
        // If we already have 9 colors, return as is
        if originalCount == 9 { return colors }
        
        // Calculate how many interpolated colors we need between each original color
        let segmentsNeeded = 8 / (originalCount - 1)
        
        for i in 0..<(originalCount - 1) {
            expandedColors.append(colors[i])
            
            // Add interpolated colors between each pair of original colors
            for j in 1...segmentsNeeded {
                let fraction = Double(j) / Double(segmentsNeeded + 1)
                expandedColors.append(interpolateColor(from: colors[i], to: colors[i + 1], fraction: fraction))
            }
        }
        
        // Add the last color
        expandedColors.append(colors[originalCount - 1])
        
        // If we need more colors to reach 9, interpolate between the last and first color
        while expandedColors.count < 9 {
            let fraction = Double(expandedColors.count - 8) / Double(9 - 8)
            expandedColors.append(interpolateColor(from: colors.last!, to: colors[0], fraction: fraction))
        }
        
        return expandedColors
    }
    
    static func interpolateColor(from color1: Color, to color2: Color, fraction: Double) -> Color {
        // Convert colors to RGB space for interpolation
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)
        
        var red1: CGFloat = 0, green1: CGFloat = 0, blue1: CGFloat = 0, alpha1: CGFloat = 0
        var red2: CGFloat = 0, green2: CGFloat = 0, blue2: CGFloat = 0, alpha2: CGFloat = 0
        
        uiColor1.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        uiColor2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        let red = red1 + (red2 - red1) * CGFloat(fraction)
        let green = green1 + (green2 - green1) * CGFloat(fraction)
        let blue = blue1 + (blue2 - blue1) * CGFloat(fraction)
        let alpha = alpha1 + (alpha2 - alpha1) * CGFloat(fraction)
        
        return Color(uiColor: UIColor(red: red, green: green, blue: blue, alpha: alpha))
    }
}
