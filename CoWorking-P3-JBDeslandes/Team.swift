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

    //    To choose a character
    var currentCharacter: Character!

    //    To define which character is the target
    var defCharacter: Character!

    //    To define which character must attack
    var atkCharacter: Character!

    //    To define which character must be healed
    var healCharacter: Character!

    // To not duplicate champion's roles
    var memRoles = [Character]()

    init(name: String) {
        self.name = name
    }

    // To control number of survivors in Team
    var alive: Bool {

        // Filter count by .life
        let numberOfTeamCharactersAlive = self.characters.filter {$1.life != constants.DEAD}.count

        // To control if the last survivor is a wizard
        if numberOfTeamCharactersAlive == 1 {

            let isWizardAlive = self.characters.filter {$1.role == .wizard && $1.life != constants.DEAD}.count

            if isWizardAlive == 1 {
                print("Voyant qu'il est le dernier survivant, le magicien de \(name) abandonne ! \n")
                // The only survivor is a wizard and can't attack
                return false
            }

        } else if numberOfTeamCharactersAlive == 0 {
            print("Tous les héros de \(name) sont morts ! \n")
            // There are no survivors
            return false
        }

        // There is at least one survivor != .wizard
        return true

    } // End of var alive

    // To control if a team can heal
    var canHeal: Bool {

        // Filter count by .maxLife
        let numberOfCharactersMaxLife = self.characters.filter {$1.life == $1.maxLife}.count

        // Filter count by dead characters
        let numberofCharactersDead = self.characters.filter {$1.life == constants.DEAD}.count

        if numberOfCharactersMaxLife == 3 {
            // Cannot heal - All team is full life
            print("Tous tes champions possèdent déjà leur santé au maximum ! \n")
            return false
        } else if numberOfCharactersMaxLife == 2 && numberofCharactersDead == 1 {
            // Cannot heal - All characters are full life or dead
            print("Tes différents champions sont soit morts, soit possèdent déjà leur santé au maximum ! \n")
            return false
        }

        // At least one character can be healed
        return true

    } // End of var canHeal

}

// MARK: - Team actions
extension Team {

    func createHero(num: Int) {

        var duplicate: Bool = false
        Message.name(num)

        repeat {
            name = readLine()!
            duplicate = false

            for double in 0..<game.memNames.count {
                if name.lowercased() == game.memNames[double] {
                    duplicate = true
                }
            }

            if duplicate == true {
                Message.usedName()
            }

        } while duplicate == true

        //        Hero's name added to memory
        game.memNames.append(name.lowercased())
        Message.choseRole(name)

        repeat {
            selectRole(num: num)
        } while noRoleDuplicate(num: num) == true

        // Hero's role added to memory
        memRoles.append(characters[num]!)

    } // End of createHero()

    func selectRole(num: Int) {

        var inputrole: Bool = false

        repeat {

            if let role = readLine() {
                switch role {
                case "1":
                    inputrole = true
                    currentCharacter = Character(name: "\(name)", role: .fighter)
                    currentCharacter.weapon = Sword()
                    Message.roleChoiced(currentCharacter, role)
                case "2":
                    inputrole = true
                    currentCharacter = Character(name: "\(name)", role: .wizard)
                    currentCharacter.weapon = Stick()
                    Message.roleChoiced(currentCharacter, role)
                case "3":
                    inputrole = true
                    currentCharacter = Character(name: "\(name)", role: .colossus)
                    currentCharacter.weapon = Fists()
                    Message.roleChoiced(currentCharacter, role)
                case "4":
                    inputrole = true
                    currentCharacter = Character(name: "\(name)", role: .dwarf)
                    currentCharacter.weapon = Axe()
                    Message.roleChoiced(currentCharacter, role)
                default:
                    inputrole = false
                    Message.roleChoiced(currentCharacter, role)
                }
                characters[num] = currentCharacter
            }

        } while inputrole == false

    } // End of selectRole()

    func noRoleDuplicate(num: Int) -> Bool {

        for double in 0..<memRoles.count where characters[num]!.role == memRoles[double].role {
            Message.noRoleDuplicate()
            return true
        }

        return false

    } // End of func noRoleDuplicate()

    func characterChoice() -> Character {

        for idk in 1...constants.CHARACTERNUMBER {
            print("\(idk). \(characters[idk]!.name)"
                + " - \(characters[idk]!.roleName)"
                + " - Vie: \(characters[idk]!.life)")
        }

        var inputChoice1: Bool = false

        repeat {

            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice1 = true
                    currentCharacter = characters[1]!
                case "2":
                    inputChoice1 = true
                    currentCharacter = characters[2]!
                case "3":
                    inputChoice1 = true
                    currentCharacter = characters[3]!
                default:
                    inputChoice1 = false
                    Message.errorChoice()
                }
                game.deadCharacter()
            }

        } while inputChoice1 == false || game.isCharacterPlayable == false

        return currentCharacter

    } // End of characterChoice()

}

// MARK: - Team reset
extension Team {

    func resetLife() {

        // Reset life and weapons
        for idk in 1...constants.CHARACTERNUMBER {
            characters[idk]!.life = characters[idk]!.maxLife
        }

    } // End of resetLife()

    func resetWeapons() {

        // Give default weapons to champions
        for idk in 1...constants.CHARACTERNUMBER {

            switch characters[idk]!.role {
            case .fighter:
                characters[idk]!.weapon = Sword()
            case .wizard:
                characters[idk]!.weapon = Stick()
            case .colossus:
                characters[idk]!.weapon = Fists()
            case .dwarf:
                characters[idk]!.weapon = Axe()
            }
        }

    } // End of resetWeapons()

}
