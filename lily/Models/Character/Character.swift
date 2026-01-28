//
//  Character.swift
//  lily
//
//  Created by Cameron Jules on 27/01/2026.
//

import Foundation
import SwiftData

@Model
final class Character {
    var id: UUID
    var name: String
    var imageName: String
    var top: String
    var shoes: String
    var scarf: String
    var necklace: String
    var leftHand: String
    var rightHand: String
    var glasses: String
    var hat: String
    var project: Project?

    init(
        id: UUID = UUID(),
        name: String,
        imageName: String,
        top: String = "",
        shoes: String = "",
        scarf: String = "",
        necklace: String = "",
        leftHand: String = "",
        rightHand: String = "",
        glasses: String = "",
        hat: String = "",
        project: Project? = nil
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.top = top
        self.shoes = shoes
        self.scarf = scarf
        self.necklace = necklace
        self.leftHand = leftHand
        self.rightHand = rightHand
        self.glasses = glasses
        self.hat = hat
        self.project = project
    }
}
