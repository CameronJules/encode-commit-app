//
//  CoinAnimationManager.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

/// Observable manager for coin fly-up animations
@Observable
class CoinAnimationManager {
    /// Currently animating coins
    var animatingCoins: [CoinAnimationItem] = []

    /// Tracked source positions (checkbox positions by todo ID)
    var sourcePositions: [UUID: CGRect] = [:]

    /// Tracked destination position (coin display in header)
    var destinationPosition: CGRect = .zero

    /// Animation parameters
    private let coinCount = 10
    private let staggerDelay = 0.05  // seconds between each coin
    private let flightDuration = 0.8  // seconds per coin

    /// Triggers coin animation from a specific todo's checkbox
    func triggerCoinAnimation(from todoId: UUID) {
        // Use source position if available, otherwise use a default position
        let sourceRect = sourcePositions[todoId] ?? CGRect(x: 200, y: 600, width: 24, height: 24)

        // Use destination position if available, otherwise use a default position
        let destRect = destinationPosition != .zero ? destinationPosition : CGRect(x: 50, y: 100, width: 16, height: 16)

        let startPoint = CGPoint(
            x: sourceRect.midX,
            y: sourceRect.midY - 40
        )
        let endPoint = CGPoint(
            x: destRect.midX,
            y: destRect.midY - 40  // Offset 40px higher
        )

        // Create coins with staggered delays
        for i in 0..<coinCount {
            let delay = Double(i) * staggerDelay
            let coin = CoinAnimationItem(
                startPosition: startPoint,
                endPosition: endPoint,
                delay: delay
            )
            animatingCoins.append(coin)
            animateCoin(coin, delay: delay)
        }
    }

    /// Animates a single coin
    private func animateCoin(_ coin: CoinAnimationItem, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            guard let self = self else { return }

            // Start the position animation
            if let index = self.animatingCoins.firstIndex(where: { $0.id == coin.id }) {
                self.animatingCoins[index].hasStarted = true
            }

            // Animate scale progress using a timer for smooth parabolic scaling
            self.animateScaleProgress(for: coin.id)

            // Remove coin after animation completes
            DispatchQueue.main.asyncAfter(deadline: .now() + self.flightDuration) { [weak self] in
                self?.animatingCoins.removeAll { $0.id == coin.id }
            }
        }
    }

    /// Animates the scale progress for parabolic scaling effect
    private func animateScaleProgress(for coinId: UUID) {
        let steps = 60 // 60 fps approximation
        let stepDuration = flightDuration / Double(steps)

        for step in 0...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + stepDuration * Double(step)) { [weak self] in
                guard let self = self,
                      let index = self.animatingCoins.firstIndex(where: { $0.id == coinId }) else {
                    return
                }
                self.animatingCoins[index].scaleProgress = Double(step) / Double(steps)
            }
        }
    }

    /// Updates source position for a todo
    func updateSourcePosition(_ rect: CGRect, for todoId: UUID) {
        sourcePositions[todoId] = rect
    }

    /// Updates the destination position
    func updateDestinationPosition(_ rect: CGRect) {
        destinationPosition = rect
    }
}
