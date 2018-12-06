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
    var weapon: Weapon

    init(name: String, role: Role) {
        self.name = name
        self.role = role

        switch role {
        case .fighter:
            roleName = "Combattant"
            life = constants.FIGHTERLIFE
            maxLife = constants.FIGHTERLIFE
            weapon = Sword()
        case .wizard:
            roleName = "Magicien"
            life = constants.WIZARDLIFE
            maxLife = constants.WIZARDLIFE
            weapon = Stick()
        case .colossus:
            roleName = "Colosse"
            life = constants.COLOSSUSLIFE
            maxLife = constants.COLOSSUSLIFE
            weapon = Fists()
        case .dwarf:
            roleName = "Nain"
            life = constants.DWARFLIFE
            maxLife = constants.DWARFLIFE
            weapon = Axe()
        }
    }

    // MARK: - ROLE
    enum Role {
        case fighter, wizard, colossus, dwarf
    }

    // To control if a character is dead
    var dead: Bool {

        if life == constants.DEAD {

            return true

        } else {

            return false

        }
    }

}
