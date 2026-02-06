//
//  TodoSlideAnimationManager.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation
import SwiftUI

/// Observable manager for todo slide-out animations
@Observable
class TodoSlideAnimationManager {
    /// IDs of todos currently sliding out
    private(set) var slidingOutTodos: Set<UUID> = []

    /// Direction each sliding todo is moving
    private(set) var slideDirections: [UUID: TodoMovementDirection] = [:]

    /// Animation duration in seconds
    private let slideDuration = 0.3

    /// Triggers a slide-out animation for a todo
    func triggerSlideAnimation(todoId: UUID, from oldStatus: TodoStatus, to newStatus: TodoStatus) {
        let direction = TodoMovementDirection.from(oldStatus: oldStatus, newStatus: newStatus)
        guard direction != .none else { return }

        slideDirections[todoId] = direction
        slidingOutTodos.insert(todoId)

        // Auto-cleanup after animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + slideDuration) { [weak self] in
            self?.slidingOutTodos.remove(todoId)
            self?.slideDirections.removeValue(forKey: todoId)
        }
    }

    /// Returns the slide direction for a specific todo
    func direction(for todoId: UUID) -> TodoMovementDirection {
        slideDirections[todoId] ?? .none
    }

    /// Returns whether a todo is currently sliding out
    func isSlidingOut(_ todoId: UUID) -> Bool {
        slidingOutTodos.contains(todoId)
    }
}
