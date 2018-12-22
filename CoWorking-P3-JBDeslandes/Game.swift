//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - GAME PROPERTIES
class Game {

//    To choose a character
    var currentCharacter: Character!

//    To define which character must attack
    var attackCharacter: Character!

//    To define which character is the target
    var defenseCharacter: Character!

//    To define which character must be healed
    var healedCharacter: Character!

//    To control which team attacks
    var attackTeam: Team!

//    To control which team defends
    var defenseTeam: Team!

//    Team creation
    var team1 = Team(name: "")
    var team2 = Team(name: "")

//    To name Characters
    private var hero: String = ""

//    To not duplicate champion's names
    private var memNames: [String] = []

//    To control if a character played
    private var characterPlayed: Bool = false

//    To control if a random chest have to appear
    private var randomTreasureAppears: Bool = false

//    To control if a character is playable
    private var isCharacterPlayable: Bool = false

//    To control when to end game
    private var isTeamPlayable: Bool = false

//    To replay with same teams
    private var replay: Bool = false

//    To replay from the beginning
    private var replayAll: Bool = false

} // End of Game class

// MARK: - GAME
extension Game {

    func mainGame() {

        // To create 2 teams
        createPlayers()

        repeat {

            // Reset value
            replayAll = false
            // To create 3 characters for 2 teams
            Message.nameChampions(team1)
            for add in 1...constants.CHARACTERNUMBER {
                createHero(team: team1, num: add)
            }
            Message.team1Created(team1)
            next()

            Message.nameChampions(team2)
            for add in 1...constants.CHARACTERNUMBER {
                createHero(team: team2, num: add)
            }
            Message.team2Created(team2)
            next()

            repeat {

                // reset value
                replay = false
                // Engage teams in battle
                battleMode()
                reset()

            } while replay == true

        } while replayAll == true

    } // End of mainGame()

    func battleMode() {

        randomTeamStart()
        var turn: Int = 0
        // Reset value
        characterPlayed = false

        repeat {

            turn += 1
            Message.turn(turn)

            for _ in 1...2 {

                repeat {
                    makeDecision()
                    next()
                } while characterPlayed == false

                deadTeam()

                if isTeamPlayable {
                    swap(&attackTeam, &defenseTeam)
                } else {
                    break
                }
            }

        } while isTeamPlayable == true

        Message.victory(turn, team1, team2)

    } // End of battleMode()

} // End of GAME

// MARK: - Teams creation
extension Game {

    func createPlayers() {

        var player1: String = ""
        var player2: String = ""
        Message.arena()
        Message.playerName(_: "Joueur 1")
        player1 = readLine()!
        team1 = Team(name: "\(player1)")
        Message.welcome1(_: player1)

        repeat {
            Message.playerName(_:"Joueur 2")
            player2 = readLine()!

            if player2.lowercased() == player1.lowercased() {
                Message.usedName()
            }

        } while player1.lowercased() == player2.lowercased()

        team2 = Team(name: "\(player2)")
        Message.welcome2(_: player2)
        next()

    } // End of createPlayer()

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

} // End of Teams creation

// MARK: - Random features
extension Game {

    func randomTeamStart() {

        let choice = Bool.random()

        if choice == true {
            attackTeam = team1
            defenseTeam = team2
        } else {
            attackTeam = team2
            defenseTeam = team1
        }

        Message.randomStart(attackTeam)
        next()

    } // End of randomTeamChoice()

    func randomTreasure() {

        // Reset value
        randomTreasureAppears = false

        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {
            randomTreasureAppears = true
            Message.randomTreasureAppears()
            next()
            changeWeapon()
        } else {
            randomTreasureAppears = false
        }

    } // End of randomTreasure()

} // End of Random features

// MARK: - Interractions
extension Game {

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
                deadCharacter()
            }

        } while inputChoice1 == false || isCharacterPlayable == false

        return currentCharacter

    } // End of characterChoice()

    func makeDecision() {

        // Reset value
        characterPlayed = false

        repeat {

            Message.attack1(attackTeam)
            attackCharacter = characterChoice(currentTeam: attackTeam)

            if attackCharacter.role == .wizard {
                heal()
            } else {
                randomTreasure()
                Message.attack2(attackTeam)
                defenseCharacter = characterChoice(currentTeam: defenseTeam)
                attack()
                characterPlayed = true
            }

        } while characterPlayed == false

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
            characterPlayed = false
            next()
        } else if attackTeam.canHeal {
            Message.heal1(attackTeam)
            healedCharacter = characterChoice(currentTeam: attackTeam)

            if healedCharacter.life == healedCharacter.maxLife {
                Message.noHeal(healedCharacter)
                characterPlayed = false
                next()

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
                characterPlayed = true
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

    func next() {

        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()

    } // End of next()

} // End of Interractions

// MARK: - End game control
extension Game {

    func deadCharacter() {

        if currentCharacter.dead == true {
            isCharacterPlayable = false
            Message.deadCharacter(currentCharacter)
        } else {
            isCharacterPlayable = true
        }

    } // End of deadCharacter()

    func deadTeam() {

        if defenseTeam.alive == false {
            Message.teamWins(attackTeam)
            attackTeam.victory += 1
            isTeamPlayable = false
        } else if attackTeam.alive == false {
            Message.teamWins(defenseTeam)
            defenseTeam.victory += 1
            isTeamPlayable = false
        } else {
            // Begin of another turn
            isTeamPlayable = true
        }

    } // End of deadTeam

} // End of End game control

// MARK: - Reset options
extension Game {

    func reset() {

        for idk in 1...constants.TEAMNUMBER {
            switch idk {
            case 1:
                resetLife(team: team1)
                resetWeapons(team: team1)
            case 2:
                resetLife(team: team2)
                resetWeapons(team: team2)
            default:
                print("Error : func reset1()")
            }

        }

       Message.resetOptions()

        if let choice = readLine() {
            switch choice {
            case "1":
                replay = true
            case "2":
                memNames.removeAll()
                team1.memRoles.removeAll()
                team2.memRoles.removeAll()
                replayAll = true
            case "3":
                print("Merci d'avoir joué !")
            default:
                print("Error : func reset2()")
            }
        }
    }

    func resetLife(team: Team) {

        // Reset life and weapons
        for idk in 1...constants.CHARACTERNUMBER {
            team.characters[idk]!.life = team.characters[idk]!.maxLife
        }

    } // End of resetLife()

    func resetWeapons(team: Team) {

        // Give default weapons to champions
        for idk in 1...constants.CHARACTERNUMBER {

            switch team.characters[idk]!.role {
            case .fighter:
                team.characters[idk]!.weapon = Sword()
            case .wizard:
                team.characters[idk]!.weapon = Stick()
            case .colossus:
                team.characters[idk]!.weapon = Fists()
            case .dwarf:
                team.characters[idk]!.weapon = Axe()
            }
        }

    } // End of resetWeapons()

} // End of Reset options
