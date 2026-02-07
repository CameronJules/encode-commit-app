//
//  ChatDTOs.swift
//  lily
//
//  Created by Cameron Jules on 07/02/2026.
//

import Foundation

// MARK: - Chat Types

enum ChatRole: String, Codable {
    case user
    case assistant
}

struct ChatMessage: Codable, Identifiable {
    var id = UUID()
    let role: ChatRole
    let content: String

    enum CodingKeys: String, CodingKey {
        case role
        case content
    }
}

// MARK: - Request DTOs

struct ChatInput: Codable {
    let messages: [ChatMessage]
}

// MARK: - Response DTOs

struct ChatOutput: Codable {
    let content: String
}
