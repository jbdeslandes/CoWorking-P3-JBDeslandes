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

    // To not duplicate champion's roles
    var memRoles = [Character]()

    init(name: String) {
        self.name = name
    }

    // To control number of survivors in Team
    var alive: Bool {

        // Filter count by .life
        let numberOfTeamCharactersAlive = self.characters.filter {$1.life != 0}.count

        // To control if the last survivor is a wizard
        if numberOfTeamCharactersAlive == 1 {

            let isWizardAlive = self.characters.filter {$1.role == .wizard}.count

            if isWizardAlive == 1 {

                print("Voyant qu'il est le dernier survivant, le magicien de \(name) abandonne !")
                print()

                // The only survivor is a wizard and can't attack
                return false

            }

        } else if numberOfTeamCharactersAlive == 0 {

            print("Tous les héros de \(name) sont morts !")
            print()

            // There are no survivors
            return false

        }

        // There is at least one survivor != .wizard
        return true

    }

    // To control if a team can heal
    var canHeal: Bool {

        // Filter count by .maxLife
        let numberOfCharactersMaxLife = self.characters.filter {$1.life == $1.maxLife}.count

        // Filter count by dead characters
        let numberofCharactersDead = self.characters.filter {$1.life == constants.DEAD}.count

        if numberOfCharactersMaxLife == 3 {

            // Cannot heal - All team is full life
            print("Tous tes champions possèdent déjà leur santé au maximum !")
            print()

            return false

        } else if numberOfCharactersMaxLife == 2 && numberofCharactersDead == 1 {

            // Cannot heal - All characters are full life or dead
            print("Tes différents champions sont soit morts, soit possèdent déjà leur santé au maximum !")
            print()

            return false

        }

        // At least one character can be healed
        return true

    }

}
