//
//  AuthService.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

struct AuthService {

    // MARK: - Dependencies

    private let networkService = NetworkService()

    // MARK: - Auth Methods

    func login(email: String, password: String) async throws -> AuthTokenResponse {
        let body = LoginRequest(email: email, password: password)
        return try await networkService.request(
            endpoint: "/auth/login",
            method: .post,
            body: body
        )
    }

    func signup(email: String, username: String?, password: String) async throws -> UserResponse {
        let body = SignupRequest(email: email, username: username, password: password)
        return try await networkService.request(
            endpoint: "/auth/signup",
            method: .post,
            body: body
        )
    }

    func refreshToken(_ refreshToken: String) async throws -> AuthTokenResponse {
        let body = RefreshTokenRequest(refreshToken: refreshToken)
        return try await networkService.request(
            endpoint: "/auth/refresh",
            method: .post,
            body: body
        )
    }

    func logout(refreshToken: String, accessToken: String) async throws {
        let body = LogoutRequest(refreshToken: refreshToken)
        try await networkService.requestNoContent(
            endpoint: "/auth/logout",
            method: .post,
            body: body,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
    }

    func getCurrentUser(accessToken: String) async throws -> UserResponse {
        return try await networkService.request(
            endpoint: "/users/me",
            method: .get,
            headers: ["Authorization": "Bearer \(accessToken)"]
        )
    }
}
