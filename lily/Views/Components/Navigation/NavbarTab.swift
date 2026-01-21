//
//  NavbarTab.swift
//  lily
//
//  Created by Cameron Jules on 21/01/2026.
//

import Foundation

enum NavbarTab: CaseIterable {
    case home
    case chat
    case shop
    case settings

    var iconName: String {
        switch self {
        case .home:
            return "house.SFSymbol"
        case .chat:
            return "chat.SFSymbol"
        case .shop:
            return "frame17"
        case .settings:
            return "cog.SFSymbol"
        }
    }
}
