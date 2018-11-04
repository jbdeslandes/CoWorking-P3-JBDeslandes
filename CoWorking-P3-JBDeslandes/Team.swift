//
//  Team.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Team {

    var name: String

    var character1: Character?
    var character2: Character?
    var character3: Character?

    init(name: String) {
        self.name = name

        self.character1 = nil
        self.character2 = nil
        self.character3 = nil
    }
}
