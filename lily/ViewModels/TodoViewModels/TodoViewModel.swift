//
//  TodoViewModel.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
final class TodoViewModel {
    // MARK: - Dependencies
    var modelContext: ModelContext?
    var walletViewModel: WalletViewModel?

    // MARK: - Movement State
    let movementState = TodoMovementState()
    let slideAnimationManager = TodoSlideAnimationManager()

    // MARK: - Bulk Edit Mode
    var isInBulkEditMode: Bool = false
    var selectedTodoIds: Set<UUID> = []

    // MARK: - Detail Sheet
    var selectedTodoForEditing: Todo?
    var isDetailSheetPresented: Bool = false
    var isCreatingNewTodo: Bool = false
    var pendingTodoSortOrder: Int = 0

    // MARK: - Edit Form State
    var editingName: String = ""
    var editingDescription: String = ""
    let subtaskViewModel = SubtaskViewModel()

    // MARK: - CRUD Methods

    func addTodo(totalCount: Int) {
        isCreatingNewTodo = true
        pendingTodoSortOrder = totalCount
        editingName = ""
        editingDescription = ""
        subtaskViewModel.clear()
        isDetailSheetPresented = true
    }

    func deleteTodo(_ todo: Todo) {
        guard let modelContext else { return }
        modelContext.delete(todo)
    }

    func deleteSelectedTodos(from todos: [Todo]) {
        guard let modelContext else { return }
        for todo in todos where selectedTodoIds.contains(todo.id) {
            modelContext.delete(todo)
        }
        exitBulkEditMode()
    }

    // MARK: - Bulk Edit Methods

    func toggleSelection(for todoId: UUID) {
        if selectedTodoIds.contains(todoId) {
            selectedTodoIds.remove(todoId)
        } else {
            selectedTodoIds.insert(todoId)
        }
    }

    func isSelected(_ todoId: UUID) -> Bool {
        selectedTodoIds.contains(todoId)
    }

    func enterBulkEditMode(startingWith todoId: UUID? = nil) {
        isInBulkEditMode = true
        selectedTodoIds.removeAll()
        if let todoId {
            selectedTodoIds.insert(todoId)
        }
    }

    func exitBulkEditMode() {
        isInBulkEditMode = false
        selectedTodoIds.removeAll()
    }

    func toggleSelectAllTodos(in todos: [Todo], forStatus status: TodoStatus) {
        let filtered = todos.filter { $0.status == status }
        let allSelected = filtered.allSatisfy { selectedTodoIds.contains($0.id) }

        if allSelected {
            for todo in filtered {
                selectedTodoIds.remove(todo.id)
            }
        } else {
            for todo in filtered {
                selectedTodoIds.insert(todo.id)
            }
        }
    }

    func activateSelectedTodos(from todos: [Todo]) {
        for todo in todos where selectedTodoIds.contains(todo.id) {
            todo.status = .active
        }
        exitBulkEditMode()
    }

    func completeSelectedTodos(from todos: [Todo]) {
        for todo in todos where selectedTodoIds.contains(todo.id) {
            let oldStatus = todo.status
            todo.status = .complete
            if oldStatus != .complete {
                walletViewModel?.awardCompletionCoins(for: todo)
            }
        }
        exitBulkEditMode()
    }

    // MARK: - Status Change Handling

    func handleStatusChange(for todo: Todo, from oldStatus: TodoStatus, to newStatus: TodoStatus) {
        movementState.recordMovement(from: oldStatus, to: newStatus)
        if newStatus == .complete && oldStatus != .complete {
            walletViewModel?.awardCompletionCoins(for: todo)
        }
    }

    // MARK: - Filtering

    /// Returns todos filtered by status
    func todos(withStatus status: TodoStatus, from todos: [Todo]) -> [Todo] {
        todos.filter { $0.status == status }
    }

    /// Returns todos filtered by status, inherently scoped to the given project
    /// - When project is provided: returns only that project's todos with the status
    /// - When project is nil (All Tasks): returns all todos with the status
    func todos(withStatus status: TodoStatus, for project: Project?, from allTodos: [Todo]) -> [Todo] {
        allTodos.filter { todo in
            let matchesStatus = todo.status == status
            let matchesProject = project == nil || todo.project?.id == project?.id
            return matchesStatus && matchesProject
        }
    }

    // MARK: - Detail Sheet Methods

    func openDetailSheet(for todo: Todo) {
        isCreatingNewTodo = false
        selectedTodoForEditing = todo
        editingName = todo.name
        editingDescription = todo.descriptionText
        subtaskViewModel.loadSubtasks(from: todo)
        isDetailSheetPresented = true
    }

    func closeDetailSheet() {
        isDetailSheetPresented = false
        selectedTodoForEditing = nil
        isCreatingNewTodo = false
        editingName = ""
        editingDescription = ""
        subtaskViewModel.clear()
    }

    func saveChanges(project: Project? = nil) {
        guard let modelContext else { return }

        if isCreatingNewTodo {
            // Create new todo only when Done is pressed
            let newTodo = Todo(name: editingName, descriptionText: editingDescription, sortOrder: pendingTodoSortOrder, project: project)
            modelContext.insert(newTodo)
            subtaskViewModel.applyChanges(to: newTodo)
        } else if let todo = selectedTodoForEditing {
            // Update existing todo
            todo.name = editingName
            todo.descriptionText = editingDescription
            subtaskViewModel.applyChanges(to: todo)
        }

        closeDetailSheet()
    }
}
