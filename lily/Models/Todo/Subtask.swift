//
//  Subtask.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation
import SwiftData

@Model
final class Subtask {
    var id: UUID
    var name: String
    var isCompleted: Bool
    var sortOrder: Int
    var parentTodo: Todo?

    init(id: UUID = UUID(), name: String, isCompleted: Bool = false, sortOrder: Int = 0, parentTodo: Todo? = nil) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.sortOrder = sortOrder
        self.parentTodo = parentTodo
    }
}
