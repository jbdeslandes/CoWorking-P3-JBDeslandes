//
//  Team.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - TEAM
class Team {

    // To name champions
    var name: String

    // Victory counter
    var victory: Int = 0

    // To store characters informations
    var characters = [Int: Character]()

    init(name: String) {
        self.name = name
    }

    // To control number of survivors in Team
    var alive: Bool {

        // Filter count by .life
        let numberOfTeamCharactersAlive = self.characters.filter {$1.life != 0}.count

        if numberOfTeamCharactersAlive == 1 {

            let teamCharacterAlive = self.characters.filter {$1.life != 0}

            // To control if the last survivor is a wizard
            if teamCharacterAlive[1]!.role == .wizard {

                // The only survivor is a wizard and can't attack
                return false

            }

        } else if numberOfTeamCharactersAlive == 0 {

            // There are no survivors
            return false

        }

        // There is at least one survivor != .wizard
        return true

    }

}
