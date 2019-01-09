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
        super.init(minDamage: Constants.SWORDDAMAGE, maxDamage: Constants.SWORDDAMAGE)
    }
}

class Stick: Weapon {
    init() {
        super.init(minDamage: Constants.STICKDAMAGEMIN, maxDamage: Constants.STICKDAMAGEMAX)
    }
}

class Fists: Weapon {
    init() {
        super.init(minDamage: Constants.FISTSDAMAGE, maxDamage: Constants.FISTSDAMAGE)
    }
}

class Axe: Weapon {
    init() {
        super.init(minDamage: Constants.AXEDAMAGE, maxDamage: Constants.AXEDAMAGE)
    }
}

// MARK: - Treasure weapons

class Mace: Weapon {
    init() {
        super.init(minDamage: Constants.MACEDAMAGEMIN, maxDamage: Constants.MACEDAMAGEMAX)
    }
}

class Dagger: Weapon {
    init() {
        super.init(minDamage: Constants.DAGGERDAMAGEMIN, maxDamage: Constants.DAGGERDAMAGEMAX)
    }
}

class Spear: Weapon {
    init() {
        super.init(minDamage: Constants.SPEARDAMAGEMIN, maxDamage: Constants.SPEARDAMAGEMAX)
    }
}
