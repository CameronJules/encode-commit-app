//
//  CreateTodoButtonView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct CreateTodoButtonView: View {
    let action: () -> Void

    private let cornerRadius: CGFloat = 12
    private let dashWidth: CGFloat = 6
    private let dashGap: CGFloat = 4

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("BluePrimary"))

                Text("Add Task")
                    .textStyle(.body1Action)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color("TodoCardBackground"))
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(
                        Color("TodoCardBorder"),
                        style: StrokeStyle(
                            lineWidth: 2,
                            dash: [dashWidth, dashGap]
                        )
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    CreateTodoButtonView {
        print("Create todo tapped")
    }
    .padding()
}
