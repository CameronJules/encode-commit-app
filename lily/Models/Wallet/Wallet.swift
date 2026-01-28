//
//  Wallet.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation
import SwiftData

@Model
final class Wallet {
    var id: UUID
    var balance: Int
    var createdAt: Date
    var lastUpdatedAt: Date

    init(id: UUID = UUID(), balance: Int = 0, createdAt: Date = Date(), lastUpdatedAt: Date = Date()) {
        self.id = id
        self.balance = balance
        self.createdAt = createdAt
        self.lastUpdatedAt = lastUpdatedAt
    }
}
