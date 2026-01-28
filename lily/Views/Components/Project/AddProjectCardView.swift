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
            VStack(spacing: 12) {
                Image("LightGreyAddFrog")
                    .resizable()
                    .scaledToFit()
                    .frame(width: FrogDisplaySize.large.dimension, height: FrogDisplaySize.large.dimension)

                Text("Create Project")
                    .font(.custom("Fredoka-SemiBold", size: 14))
                    .foregroundColor(.white.opacity(0.7))
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

        AddProjectCardView {
            print("Add project tapped")
        }
    }
}
