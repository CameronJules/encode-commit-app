//
//  ProjectFrog.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import Foundation

enum ProjectFrog: String, CaseIterable, Identifiable {
    case blue = "BlueFrog"
    case green = "GreenFrog"
    case orange = "OrangeFrog"
    case red = "RedFrog"

    var id: String { rawValue }

    var assetName: String { rawValue }
}
