//
//  MascotPlaceholderView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct MascotPlaceholderView: View {
    var projectName: String = "All Tasks"
    var onProjectButtonTap: (() -> Void)?
    var onChatButtonTap: (() -> Void)?

    // Adjust these values to change the crop position and zoom
    private let cropOffsetX: CGFloat = -200
    private let cropOffsetY: CGFloat = -170
    private let cropZoom: CGFloat = 0.8

    var body: some View {
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
    }

    private var headerView: some View {
        HStack {
            Text(projectName)
                .font(.custom("Fredoka-SemiBold", size: 18))
                .foregroundColor(.white)

            Spacer()

            if let onProjectButtonTap {
                Button {
                    onProjectButtonTap()
                } label: {
                    ProjectIconView(size: 24, circleColor: .white)
                }
                .buttonStyle(.plain)
            }
        }
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
        projectName: "Work",
        onProjectButtonTap: { print("Project button tapped") },
        onChatButtonTap: { print("Chat button tapped") }
    )
    .frame(height: 300)
}
