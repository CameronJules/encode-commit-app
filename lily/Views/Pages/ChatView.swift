//
//  ChatView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct ChatView: View {
    var onBack: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            // Full-screen background
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            // Content area
            VStack {
                Spacer()
                Text("Chat")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Custom header with back button
            HStack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.white))
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Chat")
                    .font(.custom("Fredoka-SemiBold", size: 18))
                    .foregroundColor(.primary)

                Spacer()

                // Invisible spacer to balance the header
                Color.clear
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
        }
    }
}

#Preview {
    ChatView {
        print("Back tapped")
    }
}
