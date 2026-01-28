//
//  Project.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import Foundation
import SwiftData

@Model
final class Project {
    var id: UUID
    var name: String
    var createdAt: Date
    var sortOrder: Int
    @Relationship(deleteRule: .cascade, inverse: \Todo.project) var todos: [Todo]
    @Relationship(deleteRule: .cascade, inverse: \Character.project) var character: Character?

    init(id: UUID = UUID(), name: String, character: Character? = nil, createdAt: Date = Date(), sortOrder: Int = 0, todos: [Todo] = []) {
        self.id = id
        self.name = name
        self.character = character
        self.createdAt = createdAt
        self.sortOrder = sortOrder
        self.todos = todos
    }
}
