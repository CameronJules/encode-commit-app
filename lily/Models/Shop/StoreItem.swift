//
//  StoreItem.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import Foundation

struct StoreItem: Identifiable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
    let cost: Int

    init(id: UUID = UUID(), name: String, imageName: String, cost: Int) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.cost = cost
    }
}
