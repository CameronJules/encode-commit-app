//
//  ShopCardContainerView.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI
import UIKit

struct ShopCardContainerView<Content: View>: View {
    let screenHeight: CGFloat
    @ViewBuilder var content: () -> Content

    // MARK: - Constants
    private let heightRatio: CGFloat = 0.55

    // MARK: - Computed Properties
    private var cardHeight: CGFloat {
        screenHeight * heightRatio
    }

    var body: some View {
        VStack(spacing: 0) {
            content()
        }
        .frame(height: cardHeight)
        .background(Color("ShopCardBackground"))
        .cornerRadius(24, corners: [.topLeft, .topRight])
    }
}

#Preview {
    GeometryReader { geometry in
        ZStack(alignment: .bottom) {
            Color.gray.opacity(0.3)
                .ignoresSafeArea()

            ShopCardContainerView(screenHeight: geometry.size.height) {
                VStack(spacing: 16) {
                    Text("Shop Content")
                        .font(.headline)
                        .foregroundColor(.white)

                    ForEach(0..<4) { index in
                        Text("Item \(index)")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
}
