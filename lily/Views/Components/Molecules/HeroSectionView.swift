//
//  HeroSectionView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI

struct HeroSectionView<HeaderContent: View, ActionContent: View>: View {
    var backgroundImage: String
    var cropOffsetX: CGFloat = 0
    var cropOffsetY: CGFloat = 0
    var cropZoom: CGFloat = 1.0
    @ViewBuilder var headerContent: () -> HeaderContent
    var actionContent: (() -> ActionContent)?

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                // Background image with fixed crop offset and zoom
                Image(backgroundImage)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(cropZoom)
                    .offset(x: cropOffsetX, y: cropOffsetY)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()

                // Header content overlay
                headerContent()
                    .padding(.horizontal, 20)
                    .padding(.top, 60)

                // Action content - bottom right
                if let actionContent {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            actionContent()
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 16)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.35)
                }
            }
        }
    }
}

// Convenience initializer when no action content is needed
extension HeroSectionView where ActionContent == EmptyView {
    init(
        backgroundImage: String,
        cropOffsetX: CGFloat = 0,
        cropOffsetY: CGFloat = 0,
        cropZoom: CGFloat = 1.0,
        @ViewBuilder headerContent: @escaping () -> HeaderContent
    ) {
        self.backgroundImage = backgroundImage
        self.cropOffsetX = cropOffsetX
        self.cropOffsetY = cropOffsetY
        self.cropZoom = cropZoom
        self.headerContent = headerContent
        self.actionContent = nil
    }
}

#Preview {
    HeroSectionView(
        backgroundImage: "DayBg",
        cropOffsetX: -200,
        cropOffsetY: -170,
        cropZoom: 0.8,
        headerContent: {
            HStack {
                Text("All Tasks")
                    .font(.custom("Fredoka-SemiBold", size: 18))
                    .foregroundColor(.white)
                Spacer()
            }
        },
        actionContent: {
            Button {
                print("Chat tapped")
            } label: {
                Image(systemName: "bubble.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
            }
            .buttonStyle(.plain)
        }
    )
    .frame(height: 300)
}
