//
//  StatsTabType.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation

enum StatsTabType: Int, CaseIterable {
    case tasksDone = 0

    var title: String {
        switch self {
        case .tasksDone: return "Tasks Done"
        }
    }
}
