//
//  NavbarView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct NavbarView: View {
    @Binding var selectedTab: NavbarTab

    var body: some View {
        HStack {
            ForEach(NavbarTab.allCases, id: \.self) { tab in
                Spacer()
                NavbarItemView(tab: tab, isSelected: selectedTab == tab) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        selectedTab = tab
                    }
                }
                Spacer()
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color.white)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color("TodoCardBorder"))
                .frame(height: 1)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        NavbarView(selectedTab: .constant(.home))
    }
}
