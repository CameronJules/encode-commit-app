//
//  HeroHeaderView.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import SwiftUI

struct HeroHeaderView: View {
    var projectName: String
    var taglineText: String = ""
    var coinAnimationManager: CoinAnimationManager?
    var onGridButtonTap: (() -> Void)?

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(projectName)
                    .font(.custom("Fredoka-SemiBold", size: 18))
                    .foregroundColor(.white)

                if !taglineText.isEmpty {
                    HStack(spacing: 4) {
                        Image("lily-coin")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(
                                            key: CoinDestinationPositionKey.self,
                                            value: geometry.frame(in: .named("coinAnimationSpace"))
                                        )
                                }
                            )

                        Text(taglineText)
                            .font(.custom("Fredoka-Regular", size: 14))
                            .foregroundColor(.white.opacity(0.85))
                    }
                }
            }

            Spacer()

            if let onGridButtonTap {
                Button {
                    onGridButtonTap()
                } label: {
                    Image("rounded.gridAdd")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 22)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 64)
        .background(Color(hex: "1F1E1E").opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    ZStack {
        Color.black
        VStack(spacing: 20) {
            HeroHeaderView(
                projectName: "Work",
                taglineText: "378 Lillies",
                onGridButtonTap: { print("Grid tapped") }
            )
            HeroHeaderView(
                projectName: "All Tasks",
                onGridButtonTap: { print("Grid tapped") }
            )
            HeroHeaderView(
                projectName: "Personal"
            )
        }
    }
}
