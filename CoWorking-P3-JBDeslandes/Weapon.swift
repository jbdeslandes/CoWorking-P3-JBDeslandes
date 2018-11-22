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
        super.init(minDamage: SWORDDAMAGE, maxDamage: SWORDDAMAGE)
    }
}

class Stick: Weapon {
    init() {
        super.init(minDamage: STICKDAMAGEMIN, maxDamage: STICKDAMAGEMAX)
    }
}

class Fists: Weapon {
    init() {
        super.init(minDamage: FISTSDAMAGE, maxDamage: FISTSDAMAGE)
    }
}

class Axe: Weapon {
    init() {
        super.init(minDamage: AXEDAMAGE, maxDamage: AXEDAMAGE)
    }
}

// MARK: - Treasure weapons

class Mace: Weapon {
    init() {
        super.init(minDamage: MACEDAMAGEMIN, maxDamage: MACEDAMAGEMAX)
    }
}

class Dagger: Weapon {
    init() {
        super.init(minDamage: DAGGERDAMAGEMIN, maxDamage: DAGGERDAMAGEMAX)
    }
}

class Spear: Weapon {
    init() {
        super.init(minDamage: SPEARDAMAGEMIN, maxDamage: SPEARDAMAGEMAX)
    }
}
