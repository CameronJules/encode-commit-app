//
//  MascotPlaceholderView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI

struct MascotPlaceholderView: View {
    var body: some View {
        Rectangle()
            .fill(Color(white: 0.15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MascotPlaceholderView()
        .frame(height: 300)
}
