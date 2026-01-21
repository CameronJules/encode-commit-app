//
//  ShopView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct ShopView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Shop")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ShopView()
}
