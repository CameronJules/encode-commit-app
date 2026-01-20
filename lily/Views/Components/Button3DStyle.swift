//
//  Button3DStyle.swift
//  lily
//
//  Created by Cameron Jules on 20/01/2026.
//

import SwiftUI

struct Button3DStyle: ButtonStyle {
    let color: Color
    var width: CGFloat = 85

    private let height: CGFloat = 42
    private let cornerRadius: CGFloat = 12
    private let depthHeight: CGFloat = 5

    func makeBody(configuration: Configuration) -> some View {
        let isPressed = configuration.isPressed

        ZStack(alignment: .top) {
            // Shadow - same size as face, offset down so only bottom 4px peeks out
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(darkerColor)
                .frame(width: width, height: height - depthHeight)
                .offset(y: depthHeight)

            // Face with label - moves down together when pressed
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(color)
                .frame(width: width, height: height - depthHeight)
                .overlay(
                    configuration.label
                        .font(.custom("Fredoka-SemiBold", size: 16))
                        .foregroundColor(.white)
                )
                .offset(y: isPressed ? depthHeight : 0)
        }
        .frame(width: width, height: height)
        .animation(.spring(response: 0.2, dampingFraction: 0.6), value: isPressed)
    }

    /// Computes a darker shade of the button color for the 3D depth effect
    private var darkerColor: Color {
        // Create darker version using UIColor
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        UIColor(color).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        return Color(hue: Double(hue),
                     saturation: Double(min(saturation * 1.1, 1.0)),
                     brightness: Double(brightness * 0.75))
    }
}

#Preview {
    VStack(spacing: 20) {
        Button("Done") {
            print("Button tapped!")
        }
        .buttonStyle(Button3DStyle(color: Color("GreenPrimary"), width: .infinity))

        Button("Start") {
            print("Start tapped!")
        }
        .buttonStyle(Button3DStyle(color:
                                    Color("BluePrimary"),
                                   width: .infinity))

        Button("Cancel") {
            print("Cancel tapped!")
        }
        .buttonStyle(Button3DStyle(color: Color("PurplePrimary"), width: .infinity))
    }
    .padding()
}
