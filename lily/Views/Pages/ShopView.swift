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
            Image("LitaShop")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .padding(.top, 150)
        
            Text("Coming Soon!")
                .font(.custom("Fredoka-SemiBold", size: 32))
                .foregroundColor(.litaPurple)
        
            Text("Collect lillies and unlock new items!")
                .textStyle(.tagline)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ShopView()
}
