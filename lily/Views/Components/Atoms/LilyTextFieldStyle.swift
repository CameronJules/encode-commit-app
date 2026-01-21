//
//  LilyTextFieldStyle.swift
//  lily
//
//  Created by Cameron Jules on 20/01/2026.
//

import SwiftUI

struct LilyTextFieldStyle: TextFieldStyle {
    var borderColor: Color = Color("TextFieldBorder")
    var backgroundColor: Color = Color("TextFieldBackground")
    var textColor: Color = Color("InputText")
    var width: CGFloat = .infinity
    var minHeight: CGFloat? = nil

    private let cornerRadius: CGFloat = 8

    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(.custom("Fredoka-Regular", size: 16))
            .foregroundColor(textColor)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(width: width == .infinity ? nil : width)
            .frame(maxWidth: width == .infinity ? .infinity : nil)
            .frame(minHeight: minHeight)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

#Preview {
    VStack(spacing: 20) {
        // Single-line with defaults
        TextField("Run 5k at the park", text: .constant(""))
            .textFieldStyle(LilyTextFieldStyle())

        // Single-line with text
        TextField("Task name", text: .constant("Morning workout"))
            .textFieldStyle(LilyTextFieldStyle())

        // Single-line with custom width
        TextField("Task name", text: .constant(""))
            .textFieldStyle(LilyTextFieldStyle(width: 350))

        // Multi-line with placeholder
        TextField("Description", text: .constant(""), axis: .vertical)
            .lineLimit(3...6)
            .textFieldStyle(LilyTextFieldStyle(minHeight: 100))

        // Multi-line with text
        TextField("Description", text: .constant("Remember to stretch before and after. This is a longer description that will wrap to multiple lines."), axis: .vertical)
            .lineLimit(3...6)
            .textFieldStyle(LilyTextFieldStyle(minHeight: 100))

        // Custom border color
        TextField("Custom", text: .constant(""))
            .textFieldStyle(LilyTextFieldStyle(borderColor: Color("BluePrimary")))
    }
    .padding()
}
