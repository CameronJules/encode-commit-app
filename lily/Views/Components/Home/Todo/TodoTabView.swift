//
//  TodoTabView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI
import SwiftData

struct TodoTabView: View {
    let todos: [Todo]
    var viewModel: TodoViewModel
    var projectViewModel: ProjectViewModel
    var walletViewModel: WalletViewModel
    var coinAnimationManager: CoinAnimationManager?
    var onChatButtonTap: (() -> Void)?
    @State private var selectedTab: HomeTabType = .capture

    private var heroTitle: String {
        let name = projectViewModel.selectedProjectName
        if let characterName = projectViewModel.selectedProject?.character?.name,
           !characterName.isEmpty {
            return "\(name) with \(characterName)"
        }
        return name
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                MascotPlaceholderView(
                    projectName: heroTitle,
                    taglineText: walletViewModel.formattedBalance,
                    coinAnimationManager: coinAnimationManager,
                    onProjectButtonTap: { projectViewModel.openProjectList() },
                    onChatButtonTap: onChatButtonTap
                )
                .ignoresSafeArea()

                TodoTabContainerView(
                    todos: todos,
                    viewModel: viewModel,
                    projectViewModel: projectViewModel,
                    coinAnimationManager: coinAnimationManager,
                    selectedTab: $selectedTab
                )
                .frame(height: geometry.size.height * 0.65)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, Project.self, Character.self, configurations: config)

    let todo1 = Todo(name: "Complete project proposal", descriptionText: "Draft the initial proposal")
    let todo2 = Todo(name: "Review code changes", status: .active)
    let todo3 = Todo(name: "Weekly planning session", status: .complete)

    container.mainContext.insert(todo1)
    container.mainContext.insert(todo2)
    container.mainContext.insert(todo3)

    return TodoTabView(
        todos: [todo1, todo2, todo3],
        viewModel: TodoViewModel(),
        projectViewModel: ProjectViewModel(),
        walletViewModel: WalletViewModel(),
        onChatButtonTap: { print("Chat tapped") }
    )
    .modelContainer(container)
}
