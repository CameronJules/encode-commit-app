//
//  ChatViewModel.swift
//  lily
//
//  Created by Cameron Jules on 07/02/2026.
//

import Foundation

@Observable
final class ChatViewModel {

    // MARK: - Dependencies

    private let aiService = AIService()

    // MARK: - State

    var messages: [ChatMessage] = []
    var currentInput: String = ""
    var isLoading: Bool = false
    var errorMessage: String?

    // MARK: - Methods

    func sendMessage() async {
        let trimmed = currentInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let userMessage = ChatMessage(role: .user, content: trimmed)
        messages.append(userMessage)
        currentInput = ""
        isLoading = true
        errorMessage = nil

        do {
            let output = try await aiService.sendMessage(messages: messages)
            let assistantMessage = ChatMessage(role: .assistant, content: output.content)
            messages.append(assistantMessage)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func clearMessages() {
        messages = []
        currentInput = ""
        isLoading = false
        errorMessage = nil
    }
}
