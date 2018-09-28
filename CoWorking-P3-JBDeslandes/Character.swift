//
//  Character.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Character {
    
    var name: String
    var life: Int
    var role: Role
    var roleName: String
    var weapon: Weapon?
    
    init(name: String, role: Role) {
        self.name = name
        self.role = role
        
        switch role {
        case .fighter:
            roleName = "Combattant"
            life = FIGHTER_LIFE
            weapon = nil
        case .wizard:
            roleName = "Magicien"
            life = WIZARD_LIFE
            weapon = nil
        case .colossus:
            roleName = "Colosse"
            life = COLOSSUS_LIFE
            weapon = nil
        case .dwarf:
            roleName = "Nain"
            life = DWARF_LIFE
            weapon = nil
        }
    }
}

enum Role {
    case fighter, wizard, colossus, dwarf
}
