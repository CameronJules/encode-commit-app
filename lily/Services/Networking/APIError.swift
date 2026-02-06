//
//  APIError.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int, message: String)
    case decodingError
    case networkError(Error)
    case unauthorized

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let statusCode, let message):
            return "Error \(statusCode): \(message)"
        case .decodingError:
            return "Failed to decode response"
        case .networkError(let error):
            return error.localizedDescription
        case .unauthorized:
            return "Unauthorized"
        }
    }
}
