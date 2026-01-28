//
//  CharacterViewModel.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import Foundation
import SwiftUI

@Observable
final class CharacterViewModel {
    // MARK: - State
    var selectedFrog: ProjectFrog?
    var characterName: String = ""

    // MARK: - Computed Properties
    var availableFrogs: [ProjectFrog] { ProjectFrog.allCases }

    // MARK: - Methods

    func selectFrog(_ frog: ProjectFrog) {
        selectedFrog = frog
    }

    func clear() {
        selectedFrog = nil
        characterName = ""
    }

    func loadCharacter(from character: Character?) {
        guard let character else {
            clear()
            return
        }
        characterName = character.name
        selectedFrog = ProjectFrog(rawValue: character.imageName)
    }

    func makeCharacter() -> Character? {
        guard let selectedFrog else { return nil }
        let trimmedName = characterName.trimmingCharacters(in: .whitespacesAndNewlines)
        return Character(name: trimmedName, imageName: selectedFrog.assetName)
    }

    func frogDimension(for size: FrogDisplaySize) -> CGFloat {
        size.dimension
    }
}
