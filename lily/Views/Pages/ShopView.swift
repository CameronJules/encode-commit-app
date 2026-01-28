//
//  ShopView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct ShopView: View {
    var walletViewModel: WalletViewModel
    @State private var viewModel = ShopViewModel()
    @State private var selectedTab: ShopTabType = .essentials

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ShopHeroView(walletBalance: walletViewModel.formattedBalance)
                    .ignoresSafeArea()

                ShopCardContainerView(screenHeight: geometry.size.height) {
                    VStack(spacing: 0) {
                        TabHeaderView(
                            selectedTab: $selectedTab,
                            title: selectedTab.title,
                            titleColor: .white,
                            chevronColor: .white
                        )

                        ShopItemGridView(items: viewModel.items(for: selectedTab))
                            .padding(.top, 8)

                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ShopView(walletViewModel: WalletViewModel())
}
