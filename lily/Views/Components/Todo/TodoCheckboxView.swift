//
//  TodoCheckboxView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct TodoCheckboxView: View {
    @Binding var isChecked: Bool

    private let size: CGFloat = 24
    private let cornerRadius: CGFloat = 6

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isChecked.toggle()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isChecked ? Color("BluePrimary") : Color.clear)
                    .frame(width: size, height: size)

                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(isChecked ? Color("BluePrimary") : Color("CheckboxUnchecked"), lineWidth: 2)
                    .frame(width: size, height: size)

                if isChecked {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 20) {
        TodoCheckboxView(isChecked: .constant(false))
        TodoCheckboxView(isChecked: .constant(true))
    }
    .padding()
}
