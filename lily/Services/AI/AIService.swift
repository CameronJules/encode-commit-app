//
//  AIService.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

struct AIService {

    // MARK: - Dependencies

    private let networkService = NetworkService()
    private let authService = AuthService()
    private let keychainService = KeychainService()

    // MARK: - AI Methods

    func generateSubtasks(todoName: String, todoDescription: String?) async throws -> SubtaskOutput {
        guard let accessToken = keychainService.retrieve(for: .accessToken) else {
            throw AIServiceError.notAuthenticated
        }

        let body = SubtaskInput(todoName: todoName, todoDescription: todoDescription)

        do {
            return try await performRequest(body: body, accessToken: accessToken)
        } catch APIError.unauthorized {
            let newAccessToken = try await refreshAndSaveTokens()
            return try await performRequest(body: body, accessToken: newAccessToken)
        }
    }

    func sendMessage(messages: [ChatMessage]) async throws -> ChatOutput {
        guard let accessToken = keychainService.retrieve(for: .accessToken) else {
            throw AIServiceError.notAuthenticated
        }

        let body = ChatInput(messages: messages)

        do {
            return try await performChatRequest(body: body, accessToken: accessToken)
        } catch APIError.unauthorized {
            let newAccessToken = try await refreshAndSaveTokens()
            return try await performChatRequest(body: body, accessToken: newAccessToken)
        }
    }

    // MARK: - Private

    private func performChatRequest(body: ChatInput, accessToken: String) async throws -> ChatOutput {
        try await networkService.request(
            endpoint: "/ai/chat",
            method: .post,
            body: body,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
    }

    private func performRequest(body: SubtaskInput, accessToken: String) async throws -> SubtaskOutput {
        try await networkService.request(
            endpoint: "/ai/subtask",
            method: .post,
            body: body,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
    }

    private func refreshAndSaveTokens() async throws -> String {
        guard let refreshToken = keychainService.retrieve(for: .refreshToken) else {
            throw AIServiceError.notAuthenticated
        }

        let response = try await authService.refreshToken(refreshToken)
        try keychainService.save(response.accessToken, for: .accessToken)
        try keychainService.save(response.refreshToken, for: .refreshToken)
        return response.accessToken
    }
}
