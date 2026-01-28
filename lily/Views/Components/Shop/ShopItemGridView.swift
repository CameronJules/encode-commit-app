//
//  ShopItemGridView.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

struct ShopItemGridView: View {
    let items: [StoreItem]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(items) { item in
                ShopItemTileView(item: item)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ZStack {
        Color("ShopCardBackground")
            .ignoresSafeArea()

        ShopItemGridView(items: [
            StoreItem(name: "Item 1", imageName: "LitaShop", cost: 150),
            StoreItem(name: "Item 2", imageName: "LitaShop", cost: 10000),
            StoreItem(name: "Item 3", imageName: "LitaShop", cost: 500),
            StoreItem(name: "Item 4", imageName: "LitaShop", cost: 750)
        ])
        .padding(.top, 20)
    }
}
