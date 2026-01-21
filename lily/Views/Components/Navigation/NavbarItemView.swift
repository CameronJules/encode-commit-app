//
//  NavbarItemView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct NavbarItemView: View {
    let tab: NavbarTab
    let isSelected: Bool
    let action: () -> Void

    private let iconSize: CGFloat = 28

    var body: some View {
        Button(action: action) {
            Image(tab.iconName)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: iconSize)
                .foregroundColor(isSelected ? Color("GreenPrimary") : Color("CheckboxUnchecked"))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack(spacing: 40) {
        NavbarItemView(tab: .home, isSelected: true) {}
        NavbarItemView(tab: .chat, isSelected: false) {}
        NavbarItemView(tab: .shop, isSelected: false) {}
        NavbarItemView(tab: .settings, isSelected: false) {}
    }
    .padding()
}
