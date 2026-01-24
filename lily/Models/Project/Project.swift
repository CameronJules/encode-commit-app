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
    var characterName: String
    var characterId: String
    var createdAt: Date
    var sortOrder: Int
    @Relationship(deleteRule: .cascade, inverse: \Todo.project) var todos: [Todo]

    init(id: UUID = UUID(), name: String, characterName: String = "", characterId: String = "", createdAt: Date = Date(), sortOrder: Int = 0, todos: [Todo] = []) {
        self.id = id
        self.name = name
        self.characterName = characterName
        self.characterId = characterId
        self.createdAt = createdAt
        self.sortOrder = sortOrder
        self.todos = todos
    }
}
