//
//  TodoItemView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI
import SwiftData

struct TodoItemView: View {
    @Bindable var todo: Todo
    var viewModel: TodoViewModel
    var slideDirection: TodoMovementDirection = .none

    private let cornerRadius: CGFloat = 12
    private let padding: CGFloat = 16

    private var isSelected: Bool {
        viewModel.isSelected(todo.id)
    }

    private var slideTransition: AnyTransition {
        switch slideDirection {
        case .none:
            return .opacity
        case .left:
            // Regressing (complete→active): slide out left, slide in from right
            return .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            )
        case .right:
            // Advancing (capture→active, active→complete): slide out right, slide in from left
            return .asymmetric(
                insertion: .move(edge: .leading).combined(with: .opacity),
                removal: .move(edge: .trailing).combined(with: .opacity)
            )
        }
    }

    var body: some View {
        HStack(spacing: 12) {
            // Drag handle
            Image(systemName: "line.3.horizontal")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("CheckboxUnchecked"))

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.name)
                    .font(.custom("Fredoka-Medium", size: 16))
                    .foregroundColor(Color("InputText"))
                    .strikethrough(todo.status == .complete, color: Color("CheckboxUnchecked"))

                if !todo.descriptionText.isEmpty {
                    Text(todo.descriptionText)
                        .font(.custom("Fredoka-Regular", size: 14))
                        .foregroundColor(Color("PlaceholderText"))
                        .lineLimit(1)
                }

                if !todo.subtasks.isEmpty {
                    let completedCount = todo.subtasks.filter { $0.isCompleted }.count
                    Text("\(completedCount)/\(todo.subtasks.count) next actions")
                        .font(.custom("Fredoka-Regular", size: 12))
                        .foregroundColor(Color("PlaceholderText"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Status control
            TodoStatusControlView(status: $todo.status) { oldStatus, newStatus in
                viewModel.movementState.recordMovement(from: oldStatus, to: newStatus)
            }
        }
        .padding(padding)
        .background(Color("TodoCardBackground"))
        .cornerRadius(cornerRadius)
        .transition(slideTransition)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(isSelected ? Color("BluePrimary") : Color("TodoCardBorder"), lineWidth: isSelected ? 2 : 1)
        )
        .background(
            isSelected ?
                Color("BluePrimary").opacity(0.05)
                    .cornerRadius(cornerRadius)
                : nil
        )
        .contentShape(Rectangle())
        .onTapGesture {
            if viewModel.isInBulkEditMode {
                viewModel.toggleSelection(for: todo.id)
            } else {
                viewModel.openDetailSheet(for: todo)
            }
        }
        .onLongPressGesture {
            if !viewModel.isInBulkEditMode {
                viewModel.enterBulkEditMode(startingWith: todo.id)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                viewModel.deleteTodo(todo)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Todo.self, Subtask.self, configurations: config)

    let todo1 = Todo(name: "Complete project proposal", descriptionText: "Draft the initial proposal for the client meeting")
    let todo2 = Todo(name: "Review code changes", status: .complete)
    let todo3 = Todo(name: "Weekly planning session")

    let subtask1 = Subtask(name: "Research competitors", sortOrder: 0)
    let subtask2 = Subtask(name: "Write executive summary", sortOrder: 1)
    todo1.subtasks = [subtask1, subtask2]
    subtask1.isCompleted = true

    container.mainContext.insert(todo1)
    container.mainContext.insert(todo2)
    container.mainContext.insert(todo3)

    return VStack(spacing: 12) {
        TodoItemView(todo: todo1, viewModel: TodoViewModel())
        TodoItemView(todo: todo2, viewModel: TodoViewModel())
        TodoItemView(todo: todo3, viewModel: TodoViewModel())
    }
    .padding()
    .modelContainer(container)
}
