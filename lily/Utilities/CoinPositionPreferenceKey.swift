//
//  CoinPositionPreferenceKey.swift
//  lily
//
//  Created by Cameron Jules on 28/01/2026.
//

import SwiftUI

/// PreferenceKey to track the destination position (coin display in header)
struct CoinDestinationPositionKey: PreferenceKey {
    static var defaultValue: CGRect = .zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

/// PreferenceKey to track the source positions (checkboxes) by their todo IDs
struct CoinSourcePositionKey: PreferenceKey {
    static var defaultValue: [UUID: CGRect] = [:]

    static func reduce(value: inout [UUID: CGRect], nextValue: () -> [UUID: CGRect]) {
        value.merge(nextValue()) { _, new in new }
    }
}
