//
//  HomeView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Home")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView()
}
