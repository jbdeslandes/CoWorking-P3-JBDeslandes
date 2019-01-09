//
//  Character.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

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
            life = Constants.FIGHTERLIFE
            maxLife = Constants.FIGHTERLIFE
            weapon = Sword()
        case .wizard:
            roleName = "Magicien"
            life = Constants.WIZARDLIFE
            maxLife = Constants.WIZARDLIFE
            weapon = Stick()
        case .colossus:
            roleName = "Colosse"
            life = Constants.COLOSSUSLIFE
            maxLife = Constants.COLOSSUSLIFE
            weapon = Fists()
        case .dwarf:
            roleName = "Nain"
            life = Constants.DWARFLIFE
            maxLife = Constants.DWARFLIFE
            weapon = Axe()
        }
    }

    // To control if a character is dead
    var dead: Bool {

        if life <= Constants.DEAD {
            life = Constants.DEAD
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

    func makeDecision() {

        // Reset value
        game.characterPlayed = false

        repeat {

            Message.attack1(game.atkTeam)
            game.atkTeam.atkCharacter = game.atkTeam.characterChoice()

            if game.atkTeam.atkCharacter.role == .wizard {
                heal()
            } else {
                game.randomTreasure()
                Message.attack2(game.atkTeam)
                game.defTeam.defCharacter = game.defTeam.characterChoice()
                attack()
                game.characterPlayed = true
            }

        } while game.characterPlayed == false

    } // End of makeDecision()

    func damage(_ atk: Character, _ def: Character, _ action: Int) -> Int {

        // Generator of a number in damage range
        let instantDamage = Int.random(in: atk.weapon.minDamage...atk.weapon.maxDamage)
        Message.instantDamage(instantDamage, atk, def, action)
        return instantDamage

    } // End of func damageDone()

    func attack() {

        // Generating random number
        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {
            Message.dodge(game.defTeam.defCharacter)
        } else if randomNumber > 10 && randomNumber <= 15 {
            Message.counterAttack(game.defTeam.defCharacter)
            game.atkTeam.atkCharacter.life -= damage(game.defTeam.defCharacter, game.atkTeam.atkCharacter, 1)
        } else if randomNumber > 15 && randomNumber <= 20 {
            game.defTeam.defCharacter.life -= damage(game.atkTeam.atkCharacter, game.defTeam.defCharacter, 2)*2
        } else if randomNumber > 20 && randomNumber <= 100 {
            game.defTeam.defCharacter.life -= damage(game.atkTeam.atkCharacter, game.defTeam.defCharacter, 1)
        }

        if game.defTeam.defCharacter.dead {
            Message.deadCharacter(game.defTeam.defCharacter)
        } else if game.atkTeam.atkCharacter.dead {
            Message.deadCharacter(game.atkTeam.atkCharacter)
        }

    } // End of attack()

    func heal() {

        if !game.atkTeam.canHeal {
            game.characterPlayed = false
            Message.next()
        } else if game.atkTeam.canHeal {
            Message.heal1(game.atkTeam)
            game.atkTeam.healCharacter = game.atkTeam.characterChoice()

            if game.atkTeam.healCharacter.life == game.atkTeam.healCharacter.maxLife {
                Message.noHeal(game.atkTeam.healCharacter)
                game.characterPlayed = false
                Message.next()

            } else {

              if game.atkTeam.healCharacter.life <= Constants.DEAD {
                Message.deadCharacter(game.atkTeam.healCharacter)
              } else if game.atkTeam.healCharacter.life > Constants.DEAD
                  && game.atkTeam.healCharacter.life != game.atkTeam.healCharacter.maxLife {
                  let randomNumber = Int.random(in: 1...100)
                  if randomNumber > 0 && randomNumber <= 20 {
                   // Critical heal
                   game.atkTeam.healCharacter.life += damage(game.atkTeam.atkCharacter, game.atkTeam.healCharacter, 3)*2
                  } else {
                   // Normal heal
                   game.atkTeam.healCharacter.life += damage(game.atkTeam.atkCharacter, game.atkTeam.healCharacter, 3)
                  }

                  if game.atkTeam.healCharacter.life >= game.atkTeam.healCharacter.maxLife {
                    game.atkTeam.healCharacter.life = game.atkTeam.healCharacter.maxLife
                  }
                  Message.heal2(game.atkTeam.healCharacter)
              }
                game.characterPlayed = true
            }
        }

    } // End of heal()

    func changeWeapon() {

        Message.changeWeapon(game.atkTeam.atkCharacter)
        var inputweapon: Bool = false

        repeat {

            if let weapon = readLine() {
                switch weapon {
                case "1":
                    inputweapon = true
                    game.atkTeam.atkCharacter.weapon = Mace()
                    Message.weaponChoiced(game.atkTeam.atkCharacter, weapon)
                case "2":
                    inputweapon = true
                    game.atkTeam.atkCharacter.weapon = Dagger()
                    Message.weaponChoiced(game.atkTeam.atkCharacter, weapon)
                case "3":
                    inputweapon = true
                    game.atkTeam.atkCharacter.weapon = Spear()
                    Message.weaponChoiced(game.atkTeam.atkCharacter, weapon)
                case "4":
                    inputweapon = true
                    Message.weaponChoiced(game.atkTeam.atkCharacter, weapon)
                default:
                    inputweapon = false
                    Message.weaponChoiced(game.atkTeam.atkCharacter, weapon)
                }
            }

        } while inputweapon == false

    } // End of changeWeapon()

}
