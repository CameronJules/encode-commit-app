//
//  ContentView.swift
//  lily
//
//  Created by Cameron Jules on 20/01/2026.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        VStack(spacing: 20) {
            Text("hello World")
                .font(.custom("Fredoka-Regular", size: 24))

            // Test 3D Button
            Button("Done") {
                print("3D Button tapped!")
            }
            .buttonStyle(Button3DStyle(color: .green, width: 120))

            Button("Print All Fonts") {
                for family in UIFont.familyNames.sorted() {
                    print("Family: \(family)")
                    for name in UIFont.fontNames(forFamilyName: family) {
                        print("  - \(name)")
                    }
                }
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

