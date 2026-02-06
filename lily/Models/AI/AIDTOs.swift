//
//  AIDTOs.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

// MARK: - Request DTOs

struct SubtaskInput: Codable {
    let todoName: String
    let todoDescription: String?

    enum CodingKeys: String, CodingKey {
        case todoName = "todo_name"
        case todoDescription = "todo_description"
    }
}

// MARK: - Response DTOs

struct SubtaskOutput: Codable {
    let actions: [String]
}
