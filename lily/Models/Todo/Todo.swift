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
    var sortOrder: Int
    @Relationship(deleteRule: .cascade, inverse: \Subtask.parentTodo) var subtasks: [Subtask]
    var project: Project?

    var status: TodoStatus {
        get { TodoStatus(rawValue: statusRawValue) ?? .inactive }
        set { statusRawValue = newValue.rawValue }
    }

    init(id: UUID = UUID(), name: String, descriptionText: String = "", status: TodoStatus = .inactive, createdAt: Date = Date(), sortOrder: Int = 0, subtasks: [Subtask] = [], project: Project? = nil) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.statusRawValue = status.rawValue
        self.createdAt = createdAt
        self.sortOrder = sortOrder
        self.subtasks = subtasks
        self.project = project
    }
}
