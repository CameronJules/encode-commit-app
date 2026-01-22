//
//  TodoTabContainerView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI
import SwiftData

struct TodoTabContainerView: View {
    let todos: [Todo]
    var viewModel: TodoViewModel
    @Binding var selectedTab: HomeTabType

    private let topCornerRadius: CGFloat = 24

    var body: some View {
        VStack(spacing: 0) {
            TodoTabHeaderView(selectedTab: $selectedTab)

            TabView(selection: $selectedTab) {
                ForEach(HomeTabType.allCases, id: \.self) { tabType in
                    TodoTabContentView(
                        tabType: tabType,
                        todos: todos,
                        viewModel: viewModel
                    )
                    .tag(tabType)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedTab)
        }
        .background(Color.white)
        .cornerRadius(topCornerRadius, corners: [.topLeft, .topRight])
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var selectedTab: HomeTabType = .capture

        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        var container: ModelContainer {
            try! ModelContainer(for: Todo.self, Subtask.self, configurations: config)
        }

        var body: some View {
            ZStack {
                Color(white: 0.15)
                    .ignoresSafeArea()

                TodoTabContainerView(
                    todos: [],
                    viewModel: TodoViewModel(),
                    selectedTab: $selectedTab
                )
            }
            .modelContainer(container)
        }
    }

    return PreviewWrapper()
}
