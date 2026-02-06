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
    var projectViewModel: ProjectViewModel
    var coinAnimationManager: CoinAnimationManager?
    @Binding var selectedTab: HomeTabType

    private let topCornerRadius: CGFloat = 24

    var body: some View {
        CardContainerView(backgroundColor: .white, cornerRadius: topCornerRadius) {
            VStack(spacing: 0) {
                TodoTabHeaderView(
                    selectedTab: $selectedTab,
                    movementState: viewModel.movementState,
                    viewModel: viewModel,
                    todos: todos,
                    selectedProject: projectViewModel.selectedProject
                )

                TabView(selection: $selectedTab) {
                    ForEach(HomeTabType.allCases, id: \.self) { tabType in
                        TodoTabContentView(
                            tabType: tabType,
                            todos: todos,
                            viewModel: viewModel,
                            coinAnimationManager: coinAnimationManager,
                            selectedProject: projectViewModel.selectedProject
                        )
                        .tag(tabType)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(response: 0.3, dampingFraction: 0.8), value: selectedTab)
                .highPriorityGesture(
                    viewModel.isInBulkEditMode
                        ? DragGesture().onChanged { _ in }.onEnded { _ in }
                        : nil
                )
            }
        }
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
                    projectViewModel: ProjectViewModel(),
                    selectedTab: $selectedTab
                )
            }
            .modelContainer(container)
        }
    }

    return PreviewWrapper()
}
