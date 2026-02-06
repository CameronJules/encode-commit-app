//
//  CoinAnimationOverlay.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

/// Overlay that renders all animating coins
struct CoinAnimationOverlay: View {
    var coinAnimationManager: CoinAnimationManager

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(coinAnimationManager.animatingCoins) { coin in
                    AnimatingCoinView(coin: coin)
                        .animation(.easeInOut(duration: 0.8), value: coin.hasStarted)
                }
            }
        }
        .allowsHitTesting(false)
    }
}
