//
//  TodoTabContentView.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import SwiftUI
import SwiftData

struct TodoTabContentView: View {
    let tabType: HomeTabType
    let todos: [Todo]
    var viewModel: TodoViewModel

    private var filteredTodos: [Todo] {
        todos.filter { $0.status == tabType.todoStatus }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if tabType == .capture {
                    CreateTodoButtonView {
                        viewModel.addTodo(totalCount: todos.count)
                    }
                }

                ForEach(filteredTodos) { todo in
                    TodoItemView(todo: todo, viewModel: viewModel)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 4)
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, configurations: config)

    let todo1 = Todo(name: "Complete project proposal", descriptionText: "Draft the initial proposal")
    let todo2 = Todo(name: "Review code changes")
    let todo3 = Todo(name: "Weekly planning session")

    container.mainContext.insert(todo1)
    container.mainContext.insert(todo2)
    container.mainContext.insert(todo3)

    return TodoTabContentView(
        tabType: .capture,
        todos: [todo1, todo2, todo3],
        viewModel: TodoViewModel()
    )
    .modelContainer(container)
}
