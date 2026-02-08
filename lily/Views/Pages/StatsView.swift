//
//  StatsView.swift
//  lily
//
//  Created by Cameron Jules on 24/01/2026.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Query(sort: \Todo.sortOrder) private var todos: [Todo]
    var projectViewModel: ProjectViewModel
    var walletViewModel: WalletViewModel

    @State private var selectedTab: StatsTabType = .tasksDone

    private var heroTitle: String {
        let name = projectViewModel.selectedProjectName
        if let characterName = projectViewModel.selectedProject?.character?.name,
           !characterName.isEmpty {
            return "\(name) with \(characterName)"
        }
        return name
    }

    private var filteredTodos: [Todo] {
        if let project = projectViewModel.selectedProject {
            return todos.filter { $0.project?.id == project.id }
        }
        return todos
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                MascotPlaceholderView(
                    projectName: heroTitle,
                    taglineText: walletViewModel.formattedBalance,
                    characterImageName: projectViewModel.selectedProject?.character?.imageName,
                    onProjectButtonTap: { projectViewModel.openProjectList() }
                )
                .ignoresSafeArea()

                CardContainerView(backgroundColor: .white, cornerRadius: 24) {
                    VStack(spacing: 0) {
                        TabHeaderView(
                            selectedTab: $selectedTab,
                            title: selectedTab.title
                        )

                        CalendarHeatmapView(
                            project: projectViewModel.selectedProject,
                            todos: filteredTodos
                        )
                    }
                }
                .frame(height: geometry.size.height * 0.65)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, Project.self, configurations: config)

    let todo1 = Todo(name: "Complete project proposal", status: .complete, completedAt: Date())
    let todo2 = Todo(name: "Review code changes", status: .complete, completedAt: Calendar.current.date(byAdding: .day, value: -1, to: Date()))
    let todo3 = Todo(name: "Weekly planning session", status: .complete, completedAt: Calendar.current.date(byAdding: .day, value: -3, to: Date()))

    container.mainContext.insert(todo1)
    container.mainContext.insert(todo2)
    container.mainContext.insert(todo3)

    return StatsView(projectViewModel: ProjectViewModel(), walletViewModel: WalletViewModel())
        .modelContainer(container)
}
