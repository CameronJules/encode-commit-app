//
//  ProjectRowView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct ProjectRowView: View {
    let name: String
    let isSelected: Bool
    var showIcon: Bool = true

    var body: some View {
        HStack(spacing: 12) {
            if showIcon {
                ProjectIconView(size: 20, circleColor: Color("BluePrimary"))
            }

            Text(name)
                .font(.custom("Fredoka-Medium", size: 16))
                .foregroundColor(.primary)

            Spacer()

            if isSelected {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("BluePrimary"))
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 0) {
        ProjectRowView(name: "All Tasks", isSelected: true, showIcon: false)
        Divider()
        ProjectRowView(name: "Work", isSelected: false)
        Divider()
        ProjectRowView(name: "Personal", isSelected: false)
    }
}
