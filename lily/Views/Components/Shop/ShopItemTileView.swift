//
//  ShopItemTileView.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

struct ShopItemTileView: View {
    let item: StoreItem

    var body: some View {
        VStack(spacing: 8) {
            Image(item.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .frame(height: 80)

            HStack(spacing: 4) {
                Image("lily-coin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)

                Text("\(item.cost)")
                    .font(.custom("Fredoka-SemiBold", size: 14))
                    .foregroundColor(.white)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(Color("ShopTileFill"))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color("ShopTileBorder"), lineWidth: 2)
        )
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ZStack {
        Color("ShopCardBackground")
            .ignoresSafeArea()

        ShopItemTileView(
            item: StoreItem(name: "Test Item", imageName: "LitaShop", cost: 150)
        )
        .frame(width: 150)
        .padding()
    }
}
