//
//  MascotPlaceholderView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct MascotPlaceholderView: View {
    var projectName: String = "All Tasks"
    var taglineText: String = ""
    var characterImageName: String?
    var coinAnimationManager: CoinAnimationManager?
    var onProjectButtonTap: (() -> Void)?
    var onChatButtonTap: (() -> Void)?

    // Adjust these values to change the crop position and zoom
    private let cropOffsetX: CGFloat = -200
    private let cropOffsetY: CGFloat = -170
    private let cropZoom: CGFloat = 0.8

    // Adjust these values to move the character mascot
    private let mascotOffsetX: CGFloat = -70
    private let mascotOffsetY: CGFloat = -180
    private let mascotSize: CGFloat = 170

    var body: some View {
        ZStack {
            if let onChatButtonTap {
                HeroSectionView(
                    backgroundImage: "DayBg",
                    cropOffsetX: cropOffsetX,
                    cropOffsetY: cropOffsetY,
                    cropZoom: cropZoom,
                    headerContent: { headerView },
                    actionContent: { chatButton(action: onChatButtonTap) }
                )
            } else {
                HeroSectionView(
                    backgroundImage: "DayBg",
                    cropOffsetX: cropOffsetX,
                    cropOffsetY: cropOffsetY,
                    cropZoom: cropZoom,
                    headerContent: { headerView }
                )
            }

            if let characterImageName {
                Image(characterImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: mascotSize, height: mascotSize)
                    .offset(x: mascotOffsetX, y: mascotOffsetY)
            }
        }
    }

    private var headerView: some View {
        HeroHeaderView(
            projectName: projectName,
            taglineText: taglineText,
            coinAnimationManager: coinAnimationManager,
            onGridButtonTap: onProjectButtonTap
        )
    }

    private func chatButton(action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: "bubble.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MascotPlaceholderView(
        projectName: "Work with Lily",
        taglineText: "378 Lillies",
        characterImageName: "BlueFrog",
        onProjectButtonTap: { print("Project button tapped") },
        onChatButtonTap: { print("Chat button tapped") }
    )
    .ignoresSafeArea()
}
