//
//  AuthDTOs.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

// MARK: - Request DTOs

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct SignupRequest: Codable {
    let email: String
    let username: String?
    let password: String
}

struct RefreshTokenRequest: Codable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

struct LogoutRequest: Codable {
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

// MARK: - Response DTOs

struct AuthTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let tokenType: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
    }
}

struct UserResponse: Codable {
    let id: String
    let email: String
    let username: String?
}
