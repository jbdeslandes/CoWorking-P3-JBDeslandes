//
//  Team.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - TEAM PROPERTIES

//    To name Characters
var hero: String = ""

//    To not duplicate champion's names
var memNames: [String] = []

//    To control which team attacks
var attackTeam: Team!

//    To control which team defends
var defenseTeam: Team!

//    Team creation
var team1 = Team(name: "")
var team2 = Team(name: "")

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

// MARK: - Team creation
extension Team {

    func createHero(team: Team, num: Int) {

        var duplicate: Bool = false
        Message.name(num)

        repeat {
            hero = readLine()!
            duplicate = false

            for double in 0..<memNames.count {
                if hero.lowercased() == memNames[double] {
                    duplicate = true
                }
            }

            if duplicate == true {
                Message.usedName()
            }

        } while duplicate == true

        //        Hero's name added to memory
        memNames.append(hero.lowercased())
        Message.choseRole(hero)

        repeat {
            selectRole(team: team, num: num)
        } while noRoleDuplicate(team: team, num: num) == true

        // Hero's role added to memory
        team.memRoles.append(team.characters[num]!)

    } // End of createHero()

    func selectRole(team: Team, num: Int) {

        var inputrole: Bool = false

        repeat {

            if let role = readLine() {
                switch role {
                case "1":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .fighter)
                    currentCharacter.weapon = Sword()
                    Message.roleChoiced(currentCharacter, role)
                case "2":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .wizard)
                    currentCharacter.weapon = Stick()
                    Message.roleChoiced(currentCharacter, role)
                case "3":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .colossus)
                    currentCharacter.weapon = Fists()
                    Message.roleChoiced(currentCharacter, role)
                case "4":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .dwarf)
                    currentCharacter.weapon = Axe()
                    Message.roleChoiced(currentCharacter, role)
                default:
                    inputrole = false
                    Message.roleChoiced(currentCharacter, role)
                }
                team.characters[num] = currentCharacter
            }

        } while inputrole == false

    } // End of selectRole()

    func noRoleDuplicate(team: Team, num: Int) -> Bool {

        for double in 0..<team.memRoles.count where team.characters[num]!.role == team.memRoles[double].role {
            Message.noRoleDuplicate()
            return true
        }

        return false

    } // End of func noRoleDuplicate()

}
