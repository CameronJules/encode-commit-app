//
//  FrogDisplaySize.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import Foundation

enum FrogDisplaySize {
    case small
    case medium
    case large

    var dimension: CGFloat {
        switch self {
        case .small: 40
        case .medium: 80
        case .large: 120
        }
    }
}
