//
//  HomeTabType.swift
//  lily
//
//  Created by Cameron Jules on 22/01/2026.
//

import Foundation

enum HomeTabType: Int, CaseIterable {
    case capture = 0
    case active = 1
    case complete = 2

    var title: String {
        switch self {
        case .capture: return "Capture"
        case .active: return "Active"
        case .complete: return "Complete"
        }
    }

    var todoStatus: TodoStatus {
        switch self {
        case .capture: return .inactive
        case .active: return .active
        case .complete: return .complete
        }
    }
}
