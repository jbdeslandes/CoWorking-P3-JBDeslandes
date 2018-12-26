//
//  Character.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - CHARACTER PROPERTIES

//    To choose a character
var currentCharacter: Character!

//    To define which character is the target
var defenseCharacter: Character!

//    To define which character must attack
var attackCharacter: Character!

//    To define which character must be healed
var healedCharacter: Character!

// MARK: - CHARACTER
class Character {

    // Character properties
    var name: String
    var life: Int
    var maxLife: Int
    var role: Role
    var roleName: String
    var weapon: Weapon

    init(name: String, role: Role) {
        self.name = name
        self.role = role

        switch role {
        case .fighter:
            roleName = "Combattant"
            life = constants.FIGHTERLIFE
            maxLife = constants.FIGHTERLIFE
            weapon = Sword()
        case .wizard:
            roleName = "Magicien"
            life = constants.WIZARDLIFE
            maxLife = constants.WIZARDLIFE
            weapon = Stick()
        case .colossus:
            roleName = "Colosse"
            life = constants.COLOSSUSLIFE
            maxLife = constants.COLOSSUSLIFE
            weapon = Fists()
        case .dwarf:
            roleName = "Nain"
            life = constants.DWARFLIFE
            maxLife = constants.DWARFLIFE
            weapon = Axe()
        }
    }

    // To control if a character is dead
    var dead: Bool {

        if life <= constants.DEAD {
            life = constants.DEAD
            return true
        } else {
            return false
        }
    }

    // MARK: - ROLE
    enum Role {
        case fighter, wizard, colossus, dwarf
    }

}

// MARK: - Interractions
extension Character {

    func characterChoice(currentTeam: Team) -> Character {

        for idk in 1...constants.CHARACTERNUMBER {
            print("\(idk). \(currentTeam.characters[idk]!.name)"
                + " - \(currentTeam.characters[idk]!.roleName)"
                + " - Vie: \(currentTeam.characters[idk]!.life)")
        }

        var inputChoice1: Bool = false

        repeat {

            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice1 = true
                    currentCharacter = currentTeam.characters[1]!
                case "2":
                    inputChoice1 = true
                    currentCharacter = currentTeam.characters[2]!
                case "3":
                    inputChoice1 = true
                    currentCharacter = currentTeam.characters[3]!
                default:
                    inputChoice1 = false
                    Message.errorChoice()
                }
                game.deadCharacter()
            }

        } while inputChoice1 == false || game.isCharacterPlayable == false

        return currentCharacter

    } // End of characterChoice()

    func makeDecision() {

        // Reset value
        game.characterPlayed = false

        repeat {

            Message.attack1(attackTeam)
            attackCharacter = characterChoice(currentTeam: attackTeam)

            if attackCharacter.role == .wizard {
                heal()
            } else {
                game.randomTreasure()
                Message.attack2(attackTeam)
                defenseCharacter = characterChoice(currentTeam: defenseTeam)
                attack()
                game.characterPlayed = true
            }

        } while game.characterPlayed == false

    } // End of makeDecision()

    func damageDone(atk: Character, def: Character, action: String) -> Int {

        // Generator of a number in damage range
        let instantDamage = Int.random(in: atk.weapon.minDamage...atk.weapon.maxDamage)
        Message.instantDamage(instantDamage, atk, def, action)
        return instantDamage

    } // End of func damageDone()

    func attack() {

        // Generating random number
        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {
            Message.dodge(defenseCharacter)
        } else if randomNumber > 10 && randomNumber <= 15 {
            Message.counterAttack(defenseCharacter)
            attackCharacter.life -= damageDone(atk: defenseCharacter, def: attackCharacter, action: "attack")
        } else if randomNumber > 15 && randomNumber <= 20 {
            defenseCharacter.life -= damageDone(atk: attackCharacter, def: defenseCharacter, action: "crit")*2
        } else if randomNumber > 20 && randomNumber <= 100 {
            defenseCharacter.life -= damageDone(atk: attackCharacter, def: defenseCharacter, action: "attack")
        }

        if defenseCharacter.dead {
            Message.deadCharacter(defenseCharacter)
        } else if attackCharacter.dead {
            Message.deadCharacter(attackCharacter)
        }

    } // End of attack()

    func heal() {

        if !attackTeam.canHeal {
            game.characterPlayed = false
            Message.next()
        } else if attackTeam.canHeal {
            Message.heal1(attackTeam)
            healedCharacter = characterChoice(currentTeam: attackTeam)

            if healedCharacter.life == healedCharacter.maxLife {
                Message.noHeal(healedCharacter)
                game.characterPlayed = false
                Message.next()

            } else {

                if healedCharacter.life <= constants.DEAD {
                    Message.deadCharacter(healedCharacter)
                } else if healedCharacter.life > constants.DEAD
                    && healedCharacter.life != healedCharacter.maxLife {
                    let randomNumber = Int.random(in: 1...100)
                    if randomNumber > 0 && randomNumber <= 20 {
                        // Critical heal
                        healedCharacter.life += damageDone(atk: attackCharacter, def: healedCharacter, action: "heal")*2
                    } else {
                        // Normal heal
                        healedCharacter.life += damageDone(atk: attackCharacter, def: healedCharacter, action: "heal")
                    }

                    if healedCharacter.life >= healedCharacter.maxLife {
                        healedCharacter.life = healedCharacter.maxLife
                    }
                    Message.heal2(healedCharacter)
                }
                game.characterPlayed = true
            }
        }

    } // End of heal()

    func changeWeapon() {

        Message.changeWeapon(attackCharacter)
        var inputweapon: Bool = false

        repeat {

            if let weapon = readLine() {
                switch weapon {
                case "1":
                    inputweapon = true
                    attackCharacter.weapon = Mace()
                    Message.weaponChoiced(attackCharacter, weapon)
                case "2":
                    inputweapon = true
                    attackCharacter.weapon = Dagger()
                    Message.weaponChoiced(attackCharacter, weapon)
                case "3":
                    inputweapon = true
                    attackCharacter.weapon = Spear()
                    Message.weaponChoiced(attackCharacter, weapon)
                case "4":
                    inputweapon = true
                    Message.weaponChoiced(attackCharacter, weapon)
                default:
                    inputweapon = false
                    Message.weaponChoiced(attackCharacter, weapon)
                }
            }

        } while inputweapon == false

    } // End of changeWeapon()

}
