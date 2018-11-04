//
//  Weapon.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Weapon {

    var damage: Int

    init(damage: Int) {
        self.damage = damage
    }

}

class Sword: Weapon {
    init() {
        super.init(damage: SWORDDAMAGE)
    }
}

class Stick: Weapon {
    init() {
        super.init(damage: STICKDAMAGE)
    }
}

class Fists: Weapon {
    init() {
        super.init(damage: FISTSDAMAGE)
    }
}

class Axe: Weapon {
    init() {
        super.init(damage: AXEDAMAGE)
    }
}
