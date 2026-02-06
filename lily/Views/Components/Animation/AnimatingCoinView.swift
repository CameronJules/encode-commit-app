//
//  AnimatingCoinView.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

/// View for a single animating coin
struct AnimatingCoinView: View {
    var coin: CoinAnimationItem

    private let coinSize: CGFloat = 16

    var body: some View {
        Image("lily-coin")
            .resizable()
            .scaledToFit()
            .frame(width: coinSize, height: coinSize)
            .scaleEffect(coin.scale)
            .position(x: coin.currentPosition.x, y: coin.currentPosition.y)
    }
}
