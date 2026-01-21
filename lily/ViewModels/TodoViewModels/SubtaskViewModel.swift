//
//  SubtaskViewModel.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
final class SubtaskViewModel {
    // MARK: - State
    var subtasks: [Subtask] = []

    // MARK: - Initialization

    func loadSubtasks(from todo: Todo) {
        subtasks = todo.subtasks.sorted { $0.sortOrder < $1.sortOrder }
    }

    func clear() {
        subtasks = []
    }

    // MARK: - CRUD Methods

    func addSubtask() {
        let newSubtask = Subtask(name: "", sortOrder: subtasks.count)
        subtasks.append(newSubtask)
    }

    func removeSubtask(_ subtask: Subtask) {
        subtasks.removeAll { $0.id == subtask.id }
        reorderSubtasks()
    }

    func removeSubtask(at offsets: IndexSet) {
        subtasks.remove(atOffsets: offsets)
        reorderSubtasks()
    }

    func toggleCompletion(for subtask: Subtask) {
        subtask.isCompleted.toggle()
    }

    func moveSubtask(from source: IndexSet, to destination: Int) {
        subtasks.move(fromOffsets: source, toOffset: destination)
        reorderSubtasks()
    }

    // MARK: - Helpers

    private func reorderSubtasks() {
        for (index, subtask) in subtasks.enumerated() {
            subtask.sortOrder = index
        }
    }

    func applyChanges(to todo: Todo) {
        todo.subtasks = subtasks
    }
}
