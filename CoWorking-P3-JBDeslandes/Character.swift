//
//  Character.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - CHARACTER
class Character {

    var name: String
    var life: Int
    var maxLife: Int
    var role: Role
    var roleName: String
    var weapon: Weapon?

    init(name: String, role: Role) {
        self.name = name
        self.role = role

        switch role {
        case .fighter:
            roleName = "Combattant"
            life = FIGHTERLIFE
            maxLife = FIGHTERLIFE
            weapon = nil
        case .wizard:
            roleName = "Magicien"
            life = WIZARDLIFE
            maxLife = WIZARDLIFE
            weapon = nil
        case .colossus:
            roleName = "Colosse"
            life = COLOSSUSLIFE
            maxLife = COLOSSUSLIFE
            weapon = nil
        case .dwarf:
            roleName = "Nain"
            life = DWARFLIFE
            maxLife = DWARFLIFE
            weapon = nil
        }
    }
}

// MARK: - ROLE
enum Role {
    case fighter, wizard, colossus, dwarf
}
