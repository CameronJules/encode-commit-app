//
//  CardContainerView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI
import UIKit

struct CardContainerView<Content: View>: View {
    var backgroundColor: Color = .white
    var cornerRadius: CGFloat = 24
    var roundedCorners: UIRectCorner = [.topLeft, .topRight]
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .background(backgroundColor)
            .cornerRadius(cornerRadius, corners: roundedCorners)
    }
}

#Preview {
    ZStack {
        Color(white: 0.15)
            .ignoresSafeArea()

        CardContainerView(backgroundColor: Color.white, cornerRadius: 24) {
            VStack(spacing: 16) {
                Text("Card Content")
                    .font(.headline)
                Text("This is a reusable card container")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .padding()
    }
}
