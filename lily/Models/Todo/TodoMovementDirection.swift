//
//  TodoMovementDirection.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import Foundation
import SwiftUI

enum TodoMovementDirection {
    case none
    case left
    case right

    static func from(oldStatus: TodoStatus, newStatus: TodoStatus) -> TodoMovementDirection {
        let statusOrder: [TodoStatus] = [.inactive, .active, .complete]
        guard let oldIndex = statusOrder.firstIndex(of: oldStatus),
              let newIndex = statusOrder.firstIndex(of: newStatus) else {
            return .none
        }

        if newIndex > oldIndex {
            return .right  // Advancing: capture→active, active→complete
        } else if newIndex < oldIndex {
            return .left   // Regressing: complete→active
        }
        return .none
    }
}

@Observable
final class TodoMovementState {
    var lastMovementDirection: TodoMovementDirection = .none
    var highlightedChevron: TodoMovementDirection = .none

    private var highlightTimer: Timer?

    func recordMovement(from oldStatus: TodoStatus, to newStatus: TodoStatus) {
        let direction = TodoMovementDirection.from(oldStatus: oldStatus, newStatus: newStatus)

        lastMovementDirection = direction

        // Update highlighted chevron with animation
        withAnimation(.easeInOut(duration: 0.2)) {
            highlightedChevron = direction
        }

        // Cancel existing timer and start new 2-second timer
        highlightTimer?.invalidate()
        highlightTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self?.highlightedChevron = .none
                }
            }
        }
    }

    func clearMovement() {
        lastMovementDirection = .none
    }
}
