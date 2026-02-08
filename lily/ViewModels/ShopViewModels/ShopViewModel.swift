//
//  ShopViewModel.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation

@Observable
final class ShopViewModel {
    // MARK: - Properties
    private(set) var items: [StoreItem] = []

    // MARK: - Initialization
    init() {
        fetchItems()
    }

    // MARK: - Public Methods

    func fetchItems() {
        items = [
            StoreItem(name: "Bangle Charm", imageName: "Bangle Charm", cost: 150),
            StoreItem(name: "Bangle", imageName: "Bangle", cost: 10000),
            StoreItem(name: "Necklace", imageName: "NECKLACE", cost: 500),
            StoreItem(name: "Scarf", imageName: "Scarf", cost: 750)
        ]
    }

    func items(for category: ShopTabType) -> [StoreItem] {
        switch category {
        case .essentials:
            return items
        }
    }
}
