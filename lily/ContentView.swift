//
//  ContentView.swift
//  lily
//
//  Created by Cameron Jules on 20/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab: NavbarTab = .home

    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .chat:
                    ChatView()
                case .shop:
                    ShopView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            NavbarView(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Todo.self, Subtask.self], inMemory: true)
}
