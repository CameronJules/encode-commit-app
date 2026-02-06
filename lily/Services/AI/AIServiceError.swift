//
//  AIServiceError.swift
//  lily
//
//  Created by Cameron Jules on 06/02/2026.
//

import Foundation

enum AIServiceError: LocalizedError {
    case notAuthenticated

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "Please log in to use AI features"
        }
    }
}
