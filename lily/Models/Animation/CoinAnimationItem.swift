//
//  CoinAnimationItem.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation
import CoreGraphics

/// Model representing a single animating coin
struct CoinAnimationItem: Identifiable {
    let id = UUID()
    let startPosition: CGPoint
    let endPosition: CGPoint
    let delay: Double

    /// Whether the animation has started (used to trigger position change)
    var hasStarted: Bool = false

    /// Animation progress for scale calculation (0 to 1)
    var scaleProgress: Double = 0

    /// Parabolic scale: 1x at start, 2x at midpoint, 1x at end
    var scale: Double {
        let parabola = -4 * pow(scaleProgress - 0.5, 2) + 1
        return 1.0 + parabola
    }

    /// Current position - returns end position when started, start position otherwise
    var currentPosition: CGPoint {
        hasStarted ? endPosition : startPosition
    }
}
