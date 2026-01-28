//
//  ShopTabType.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation

enum ShopTabType: Int, CaseIterable {
    case essentials = 0

    var title: String {
        switch self {
        case .essentials: return "Everyday Essentials"
        }
    }
}
