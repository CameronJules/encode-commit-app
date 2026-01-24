//
//  ProjectIconView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct ProjectIconView: View {
    var size: CGFloat = 24
    var circleColor: Color = .white

    private var circleSize: CGFloat {
        (size - 4) / 2
    }

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleSize, height: circleSize)
                Circle()
                    .fill(circleColor)
                    .frame(width: circleSize, height: circleSize)
            }
            HStack(spacing: 4) {
                Circle()
                    .fill(circleColor)
                    .frame(width: circleSize, height: circleSize)
                Circle()
                    .fill(circleColor)
                    .frame(width: circleSize, height: circleSize)
            }
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    ZStack {
        Color.black
        ProjectIconView()
    }
}
