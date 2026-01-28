//
//  ShopHeroView.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

struct ShopHeroView: View {
    var walletBalance: String

    var body: some View {
        HeroSectionView(
            backgroundImage: "lily-shop-screen",
            cropOffsetX: 0,
            cropOffsetY: -120,
            cropZoom: 1.0
        ) {
            HeroHeaderView(
                projectName: "Lily's Boutique",
                taglineText: walletBalance
            )
        }
    }
}

#Preview {
    ShopHeroView(walletBalance: "378 Lillies")
        .ignoresSafeArea()
}
