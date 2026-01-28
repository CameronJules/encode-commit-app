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
            StoreItem(name: "Item 1", imageName: "shop-item-1", cost: 150),
            StoreItem(name: "Item 2", imageName: "shop-item-2", cost: 10000),
            StoreItem(name: "Item 3", imageName: "shop-item-3", cost: 500),
            StoreItem(name: "Item 4", imageName: "shop-item-4", cost: 750)
        ]
    }

    func items(for category: ShopTabType) -> [StoreItem] {
        switch category {
        case .essentials:
            return items
        }
    }
}
