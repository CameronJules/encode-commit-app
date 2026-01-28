//
//  Todo.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var id: UUID
    var name: String
    var descriptionText: String
    var statusRawValue: String
    var createdAt: Date
    var completedAt: Date?
    var sortOrder: Int
    @Relationship(deleteRule: .cascade, inverse: \Subtask.parentTodo) var subtasks: [Subtask]
    var project: Project?
    var coinsAwarded: Bool = false

    var status: TodoStatus {
        get { TodoStatus(rawValue: statusRawValue) ?? .inactive }
        set {
            let oldStatus = TodoStatus(rawValue: statusRawValue) ?? .inactive
            statusRawValue = newValue.rawValue

            // Update completedAt when transitioning TO .complete
            if newValue == .complete && oldStatus != .complete {
                completedAt = Date()
            }
            // Note: completedAt is preserved when moving away from .complete
        }
    }

    init(id: UUID = UUID(), name: String, descriptionText: String = "", status: TodoStatus = .inactive, createdAt: Date = Date(), completedAt: Date? = nil, sortOrder: Int = 0, subtasks: [Subtask] = [], project: Project? = nil, coinsAwarded: Bool = false) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.statusRawValue = status.rawValue
        self.createdAt = createdAt
        self.completedAt = completedAt
        self.sortOrder = sortOrder
        self.subtasks = subtasks
        self.project = project
        self.coinsAwarded = coinsAwarded
    }
}
