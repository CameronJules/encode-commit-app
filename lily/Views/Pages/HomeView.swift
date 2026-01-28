//
//  HomeView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Todo.sortOrder) private var todos: [Todo]
    @State private var viewModel = TodoViewModel()
    var projectViewModel: ProjectViewModel
    var walletViewModel: WalletViewModel
    var onChatButtonTap: (() -> Void)?

    var body: some View {
        TodoTabView(todos: todos, viewModel: viewModel, projectViewModel: projectViewModel, walletViewModel: walletViewModel, onChatButtonTap: onChatButtonTap)
            .onAppear {
                viewModel.modelContext = modelContext
                viewModel.walletViewModel = walletViewModel
                walletViewModel.modelContext = modelContext
                projectViewModel.modelContext = modelContext
            }
            .sheet(isPresented: $viewModel.isDetailSheetPresented) {
                TodoDetailSheet(viewModel: viewModel, selectedProject: projectViewModel.selectedProject)
            }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, Project.self, configurations: config)

    let todo1 = Todo(name: "Complete project proposal", descriptionText: "Draft the initial proposal")
    let todo2 = Todo(name: "Review code changes", status: .active)
    let todo3 = Todo(name: "Weekly planning session", status: .complete)

    container.mainContext.insert(todo1)
    container.mainContext.insert(todo2)
    container.mainContext.insert(todo3)

    return HomeView(projectViewModel: ProjectViewModel(), walletViewModel: WalletViewModel(), onChatButtonTap: { print("Chat tapped") })
        .modelContainer(container)
}
