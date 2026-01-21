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
    var status: TodoStatus
    var createdAt: Date
    var sortOrder: Int
    @Relationship(deleteRule: .cascade, inverse: \Subtask.parentTodo) var subtasks: [Subtask]

    init(id: UUID = UUID(), name: String, descriptionText: String = "", status: TodoStatus = .inactive, createdAt: Date = Date(), sortOrder: Int = 0, subtasks: [Subtask] = []) {
        self.id = id
        self.name = name
        self.descriptionText = descriptionText
        self.status = status
        self.createdAt = createdAt
        self.sortOrder = sortOrder
        self.subtasks = subtasks
    }
}
