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

    // Adjust these values to change the crop position and zoom
    private let cropOffsetX: CGFloat = -200
    private let cropOffsetY: CGFloat = -170
    private let cropZoom: CGFloat = 0.8

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background image with fixed crop offset and zoom
                Image("DayBg")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(cropZoom)
                    .offset(x: cropOffsetX, y: cropOffsetY)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()

                // Overlay UI
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
                .padding(.horizontal, 20)
                .padding(.top, 60)
            }
        }
    }
}

#Preview {
    MascotPlaceholderView(projectName: "Work") {
        print("Project button tapped")
    }
    .frame(height: 300)
}
