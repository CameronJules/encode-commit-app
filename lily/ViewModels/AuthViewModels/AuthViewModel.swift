//
//  AuthViewModel.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

@Observable
final class AuthViewModel {

    // MARK: - Dependencies

    private let authService = AuthService()
    private let keychainService = KeychainService()

    // MARK: - State

    var isAuthenticated: Bool = false
    var currentUser: UserResponse?
    var errorMessage: String?
    var isLoading: Bool = false

    // MARK: - Init

    init() {
        if getAccessToken() != nil {
            isAuthenticated = true
            Task { await fetchCurrentUser() }
        }
    }

    // MARK: - Public Methods

    func login(email: String, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await authService.login(email: email, password: password)
            try keychainService.save(response.accessToken, for: .accessToken)
            try keychainService.save(response.refreshToken, for: .refreshToken)
            isAuthenticated = true
            await fetchCurrentUser()
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func signup(email: String, username: String?, password: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let _ = try await authService.signup(email: email, username: username, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func logout() async {
        isLoading = true
        errorMessage = nil

        if let refreshToken = getRefreshToken(), let accessToken = getAccessToken() {
            try? await authService.logout(refreshToken: refreshToken, accessToken: accessToken)
        }

        keychainService.deleteAll()
        isAuthenticated = false
        currentUser = nil
        isLoading = false
    }

    func getAccessToken() -> String? {
        keychainService.retrieve(for: .accessToken)
    }

    func getRefreshToken() -> String? {
        keychainService.retrieve(for: .refreshToken)
    }

    // MARK: - Private Methods

    private func fetchCurrentUser() async {
        guard let accessToken = getAccessToken() else { return }

        do {
            currentUser = try await authService.getCurrentUser(accessToken: accessToken)
        } catch {
            // Token may be expired — clear auth state
            keychainService.deleteAll()
            isAuthenticated = false
            currentUser = nil
        }
    }
}
