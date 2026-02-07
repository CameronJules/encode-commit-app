//
//  ChatView.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import SwiftUI

struct ChatView: View {
    var chatViewModel: ChatViewModel
    var onBack: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            // Full-screen background
            Color(UIColor.systemBackground)
                .ignoresSafeArea()

            // Content area
            VStack(spacing: 0) {
                // Header spacer
                Color.clear
                    .frame(height: 100)

                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(chatViewModel.messages) { message in
                                ChatBubbleView(message: message)
                                    .id(message.id)
                            }

                            if chatViewModel.isLoading {
                                HStack {
                                    ProgressView()
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .onChange(of: chatViewModel.messages.count) {
                        if let lastMessage = chatViewModel.messages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }

                // Error message
                if let errorMessage = chatViewModel.errorMessage {
                    Text(errorMessage)
                        .font(.custom("Fredoka-Regular", size: 14))
                        .foregroundColor(.red)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 4)
                }

                // Input bar
                ChatInputBar(chatViewModel: chatViewModel)
            }

            // Custom header with back button
            HStack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                        .frame(width: 32, height: 32)
                        .background(Circle().fill(Color.white))
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Chat")
                    .font(.custom("Fredoka-SemiBold", size: 18))
                    .foregroundColor(.primary)

                Spacer()

                // Invisible spacer to balance the header
                Color.clear
                    .frame(width: 32, height: 32)
            }
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .background(Color(UIColor.systemBackground))
        }
    }
}

// MARK: - Chat Bubble

private struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .user { Spacer() }

            Text(message.content)
                .font(.custom("Fredoka-Regular", size: 16))
                .foregroundColor(message.role == .user ? .white : Color("BodyText"))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(
                    message.role == .user
                        ? Color("BluePrimary")
                        : Color("TextFieldBackground")
                )
                .cornerRadius(16)

            if message.role == .assistant { Spacer() }
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Input Bar

private struct ChatInputBar: View {
    @Bindable var chatViewModel: ChatViewModel

    var body: some View {
        HStack(spacing: 10) {
            TextField("Type a message...", text: $chatViewModel.currentInput)
                .textFieldStyle(LilyTextFieldStyle())

            Button {
                Task {
                    await chatViewModel.sendMessage()
                }
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(
                        chatViewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chatViewModel.isLoading
                            ? Color.gray
                            : Color("BluePrimary")
                    )
            }
            .buttonStyle(.plain)
            .disabled(
                chatViewModel.currentInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || chatViewModel.isLoading
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    ChatView(chatViewModel: ChatViewModel()) {
        print("Back tapped")
    }
}
