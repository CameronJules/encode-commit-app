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
    @State private var isShowingProjectList: Bool = false
    @State private var isShowingChat: Bool = false
    @State private var projectViewModel = ProjectViewModel()
    @State private var walletViewModel = WalletViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView(projectViewModel: projectViewModel, walletViewModel: walletViewModel, onChatButtonTap: {
                            isShowingChat = true
                        })
                    case .stats:
                        StatsView(projectViewModel: projectViewModel, walletViewModel: walletViewModel)
                    case .shop:
                        ShopView(walletViewModel: walletViewModel)
                    case .settings:
                        SettingsView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                NavbarView(selectedTab: $selectedTab)
            }

            if isShowingProjectList {
                ProjectListView(viewModel: projectViewModel) {
                    isShowingProjectList = false
                    projectViewModel.isProjectListPresented = false
                }
                .transition(.move(edge: .trailing))
                .zIndex(1)
            }

            if isShowingChat {
                ChatView {
                    isShowingChat = false
                }
                .transition(.move(edge: .trailing))
                .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isShowingProjectList)
        .animation(.easeInOut(duration: 0.3), value: isShowingChat)
        .ignoresSafeArea(.keyboard)
        .onChange(of: projectViewModel.isProjectListPresented) { _, newValue in
            isShowingProjectList = newValue
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Todo.self, Subtask.self, Project.self, Character.self, Wallet.self], inMemory: true)
}
