//
//  AddProjectCardView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct AddProjectCardView: View {
    var onTap: () -> Void

    var body: some View {
        Button {
            onTap()
        } label: {
            // Dotted border square with plus icon
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8, 4]))
                .foregroundColor(Color(white: 0.6))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "plus")
                        .font(.system(size: 32, weight: .medium))
                        .foregroundColor(Color(white: 0.6))
                )
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

        AddProjectCardView {
            print("Add project tapped")
        }
    }
}
