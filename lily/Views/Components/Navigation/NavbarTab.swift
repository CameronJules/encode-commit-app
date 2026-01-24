//
//  NavbarTab.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation

enum NavbarTab: CaseIterable {
    case home
    case stats
    case shop
    case settings

    var iconName: String {
        switch self {
        case .home:
            return "house.SFSymbol"
        case .stats:
            return "award.SFSymbol"
        case .shop:
            return "rounded.shop"
        case .settings:
            return "profile.SFSymbol"
        }
    }
}
