//
//  Weapon.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - WEAPON
class Weapon {

    var minDamage: Int

    var maxDamage: Int

    init(minDamage: Int, maxDamage: Int) {

        self.minDamage = minDamage
        self.maxDamage = maxDamage

    }

}

// MARK: - Default weapons
class Sword: Weapon {
    init() {
        super.init(minDamage: constants.SWORDDAMAGE, maxDamage: constants.SWORDDAMAGE)
    }
}

class Stick: Weapon {
    init() {
        super.init(minDamage: constants.STICKDAMAGEMIN, maxDamage: constants.STICKDAMAGEMAX)
    }
}

class Fists: Weapon {
    init() {
        super.init(minDamage: constants.FISTSDAMAGE, maxDamage: constants.FISTSDAMAGE)
    }
}

class Axe: Weapon {
    init() {
        super.init(minDamage: constants.AXEDAMAGE, maxDamage: constants.AXEDAMAGE)
    }
}

// MARK: - Treasure weapons

class Mace: Weapon {
    init() {
        super.init(minDamage: constants.MACEDAMAGEMIN, maxDamage: constants.MACEDAMAGEMAX)
    }
}

class Dagger: Weapon {
    init() {
        super.init(minDamage: constants.DAGGERDAMAGEMIN, maxDamage: constants.DAGGERDAMAGEMAX)
    }
}

class Spear: Weapon {
    init() {
        super.init(minDamage: constants.SPEARDAMAGEMIN, maxDamage: constants.SPEARDAMAGEMAX)
    }
}
