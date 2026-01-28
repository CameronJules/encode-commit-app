//
//  WalletViewModel.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation
import SwiftData

@Observable
final class WalletViewModel {
    // MARK: - Dependencies
    var modelContext: ModelContext?

    // MARK: - Private Properties
    private var wallet: Wallet?

    // MARK: - Computed Properties

    var balance: Int {
        getOrCreateWallet()?.balance ?? 0
    }

    var formattedBalance: String {
        "\(balance) Lillies"
    }

    // MARK: - Public Methods

    func addCoins(_ amount: Int) {
        guard let wallet = getOrCreateWallet() else { return }
        wallet.balance += amount
        wallet.lastUpdatedAt = Date()
    }

    func decrementCoins(_ amount: Int) -> Bool {
        guard let wallet = getOrCreateWallet(), wallet.balance >= amount else { return false }
        wallet.balance -= amount
        wallet.lastUpdatedAt = Date()
        return true
    }

    func canAfford(_ amount: Int) -> Bool {
        balance >= amount
    }

    func awardCompletionCoins(for todo: Todo) {
        guard !todo.coinsAwarded else { return }
        todo.coinsAwarded = true
        addCoins(10)
    }

    // MARK: - Private Methods

    @discardableResult
    func getOrCreateWallet() -> Wallet? {
        if let wallet = wallet {
            return wallet
        }

        guard let modelContext else { return nil }

        let descriptor = FetchDescriptor<Wallet>()
        if let existingWallet = try? modelContext.fetch(descriptor).first {
            wallet = existingWallet
            return existingWallet
        }

        let newWallet = Wallet()
        modelContext.insert(newWallet)
        wallet = newWallet
        return newWallet
    }
}
