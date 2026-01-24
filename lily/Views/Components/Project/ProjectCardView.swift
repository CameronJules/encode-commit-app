//
//  ProjectCardView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct ProjectCardView: View {
    let characterName: String
    let projectName: String
    var onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(spacing: 12) {
                // Character image placeholder
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(white: 0.85))
                    .frame(width: 100, height: 100)

                // Text container
                VStack(spacing: 4) {
                    Text(characterName.isEmpty ? "Character" : characterName)
                        .font(.custom("Fredoka-SemiBold", size: 18))
                        .foregroundColor(.white)

                    Text(projectName)
                        .font(.custom("Fredoka-Regular", size: 14))
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .frame(minWidth: 150)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.4))
                )
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ZStack {
        Image("ProjectDayBg")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        ProjectCardView(
            characterName: "Lily",
            projectName: "Work Tasks"
        ) {
            print("Card tapped")
        }
    }
}
