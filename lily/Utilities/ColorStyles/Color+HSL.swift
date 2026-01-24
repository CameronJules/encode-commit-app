//
//  Color+HSL.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

extension Color {
    /// Initialize from HSL values (SwiftUI uses HSB natively)
    /// - Parameters:
    ///   - h: Hue in degrees (0-360)
    ///   - s: Saturation (0-1)
    ///   - l: Lightness (0-1)
    static func hsl(h: Double, s: Double, l: Double) -> Color {
        let brightness = l + s * min(l, 1 - l)
        let saturation = brightness == 0 ? 0 : 2 * (1 - l / brightness)
        return Color(hue: h / 360.0, saturation: saturation, brightness: brightness)
    }

    /// Initialize from hex string (e.g., "#F7F7F7" or "F7F7F7")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255)
    }
}
