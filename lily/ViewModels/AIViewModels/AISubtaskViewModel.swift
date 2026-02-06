//
//  AISubtaskViewModel.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

@Observable
final class AISubtaskViewModel {

    // MARK: - Dependencies

    private let aiService = AIService()

    // MARK: - State

    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Methods

    func generateSubtasks(
        todoName: String,
        todoDescription: String,
        into subtaskViewModel: SubtaskViewModel
    ) async {
        isLoading = true
        errorMessage = nil

        do {
            let descriptionToSend = todoDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                ? nil
                : todoDescription

            let output = try await aiService.generateSubtasks(
                todoName: todoName,
                todoDescription: descriptionToSend
            )

            let currentCount = subtaskViewModel.subtasks.count
            for (index, actionName) in output.actions.enumerated() {
                let subtask = Subtask(
                    name: actionName,
                    sortOrder: currentCount + index
                )
                subtaskViewModel.subtasks.append(subtask)
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
