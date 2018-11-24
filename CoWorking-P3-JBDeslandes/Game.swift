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
    private var isCharacterDead: Bool = false

//    To control when to end game
    private var isTeamDead: Bool = false

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
            print("\(team1.name) - Choisis le nom des héros qui composeront ton équipe !")
            print()

            for add in 1...constants.CHARACTERNUMBER {
                createHero(team: team1, num: add)
            }

            print("\(team1.name) - Tes champions"
                + " \(team1.characters[1]!.name), \(team1.characters[2]!.name) et \(team1.characters[3]!.name)"
                + " atteignent l'arène et attendent leurs adversaires de pied ferme..")
            print()

            next()

            print("\(team2.name) - A toi maintenant de choisir le nom des héros qui composeront ton équipe !")
            print()

            for add in 1...constants.CHARACTERNUMBER {
                createHero(team: team2, num: add)
            }

            print("\(team2.name) - Tes champions"
                + " \(team2.characters[1]!.name), \(team2.characters[2]!.name) et \(team2.characters[3]!.name)"
                + " rejoignent l'enceinte et font face à leurs rivaux..")
            print()

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

            print("--- TOUR \(turn) ---")
            print()

            for _ in 1...2 {

                repeat {

                    makeDecision()

                    next()

                } while characterPlayed == false

                deadTeam()

                if !isTeamDead {

                    swap(&attackTeam, &defenseTeam)

                } else {

                    break

                }

            }

        } while isTeamDead == false

        print("FIN DU COMBAT EN \(turn) TOURS !")
        print()
        print("VICTOIRES : \(team1.name): \(team1.victory) / \(team2.name): \(team2.victory)")
        print()

    } // End of battleMode()

} // End of GAME

// MARK: - Teams creation
extension Game {

    func createPlayers() {

        print("Bienvenue dans l'arène !")
        print()

        var player1: String = ""
        var player2: String = ""

        print("Joueur 1 - Quel est ton nom ?", terminator: " ")

        player1 = readLine()!

        team1 = Team(name: "\(player1)")
        print("Force & Honneur, \(player1) !")
        print()

        repeat {

            print("Joueur 2 - Quel est ton nom ?", terminator: " ")

            player2 = readLine()!

            if player2.lowercased() == player1.lowercased() {

                print("Ce nom est déjà pris, veuillez recommencer.")
                print()

            }

        } while player1.lowercased() == player2.lowercased()

        team2 = Team(name: "\(player2)")
        print("Esprit & Robustesse sur toi, \(player2) !")
        print()

        next()

    } // End of createPlayer()

    func createHero(team: Team, num: Int) {

        var duplicate: Bool = false

        print("Quel est le nom de ton champion numéro \(num) ?")

        repeat {

            hero = readLine()!

            duplicate = false

                for double in 0..<memNames.count {
                    if hero.lowercased() == memNames[double] {
                        duplicate = true
                    }
                }

                if duplicate == true {

                    print("Ce nom est déjà pris, veuillez recommencer.")
                }

        } while duplicate == true

        //        Hero's name added to memory
        memNames.append(hero.lowercased())

        print()

        print("Quelle sera la classe de \(hero) ?"
            + "\n1. Combattant" + " - ATQ: \(constants.SWORDDAMAGE)"
            + " / PV: \(constants.FIGHTERLIFE)" + " - Guerrier équilibré"
            + "\n2. Magicien" + " - ATQ: \(constants.DEAD)"
            + " / PV: \(constants.WIZARDLIFE)" + " - Ne combat pas / Soigneur efficace"
            + "\n3. Colosse" + " - ATQ: \(constants.FISTSDAMAGE)"
            + " / PV: \(constants.COLOSSUSLIFE)" + " - Faible puissance / Très résistant"
            + "\n4. Nain" + " - ATQ: \(constants.AXEDAMAGE)"
            + " / PV: \(constants.DWARFLIFE)" + " - Grande puissance / Peu résistant")

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
                    print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                        + " attrape une épée tranchante dans le râtelier d'arme le plus proche !")
                case "2":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .wizard)
                    currentCharacter.weapon = Stick()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                        + " invoque son septre magique !")
                case "3":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .colossus)
                    currentCharacter.weapon = Fists()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                        + " n'a besoin d'aucune arme pour écraser ses adversaires !")
                case "4":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .dwarf)
                    currentCharacter.weapon = Axe()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName)"
                        + " se saisit de sa hache préférée !")
                default:
                    inputrole = false
                    print("Je n'ai pas compris votre choix."
                        + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }

                print()
                team.characters[num] = currentCharacter
            }

        } while inputrole == false

    } // End of selectRole()

    func noRoleDuplicate(team: Team, num: Int) -> Bool {

        for double in 0..<team.memRoles.count {

            if team.characters[num]!.role == team.memRoles[double].role {

                print("Vous possèdez déjà un champion de cette classe !")

                return true

            }

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

        print("Le peuple a parlé ! L'équipe de \(attackTeam.name) donnera le premier assaut !")
        print()
        print("QUE LE COMBAT COMMENCE !")
        print()

        next()

    } // End of randomTeamChoice()

    func randomTreasure() {

        // Reset value
        randomTreasureAppears = false

        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {

            randomTreasureAppears = true

            print("UN COFFRE MAGIQUE APPARAIT !")
            print()

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

        print("\n1. \(currentTeam.characters[1]!.name)"
            + " - \(currentTeam.characters[1]!.roleName)"
            + " - Vie: \(currentTeam.characters[1]!.life)"

            + "\n2. \(currentTeam.characters[2]!.name)"
            + " - \(currentTeam.characters[2]!.roleName)"
            + " - Vie: \(currentTeam.characters[2]!.life)"

            + "\n3. \(currentTeam.characters[3]!.name)"
            + " - \(currentTeam.characters[3]!.roleName)"
            + " - Vie: \(currentTeam.characters[3]!.life)")

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
                    print("Je n'ai pas compris votre choix."
                        + " Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }

                deadCharacter()

            }

        } while inputChoice1 == false || isCharacterDead == true

        return currentCharacter

    } // End of characterChoice()

    func makeDecision() {

        // Reset value
        characterPlayed = false

        repeat {

            print("\(attackTeam.name) - Quel champion souhaites-tu jouer ?")

            attackCharacter = characterChoice(currentTeam: attackTeam)

            if attackCharacter.role == .wizard {

                heal()

            } else {

                randomTreasure()

                print("\(attackTeam.name) - Quel adversaire souhaites-tu attaquer ?")
                defenseCharacter = characterChoice(currentTeam: defenseTeam)

                attack()

                characterPlayed = true

            }

        } while characterPlayed == false

    } // End of makeDecision()

    func damageDone(atk: Character, def: Character, action: String) -> Int {

        // Generator of a number in damage range
        let instantDamage = Int.random(in: atk.weapon.minDamage...atk.weapon.maxDamage)

        if action == "attack" {

            print("\(atk.name) inflige \(instantDamage) points de dégâts à \(def.name).")
            print()

        } else if action == "heal" {

            print("\(atk.name) soigne \(instantDamage) points de vie de \(def.name).")
            print()

        } else if action == "crit" {

            print("\(atk.name) trouve une faille dans la défense de"
                + " \(def.name) et assène un coup critique de \(instantDamage * 2) points de dégâts !")

        }

        return instantDamage

    } // End of func damageDone()

    func attack() {

        // Generating random number
        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {

            // Dodge
            print("\(defenseCharacter.name) esquive l'assaut !")
            print()

        } else if randomNumber > 10 && randomNumber <= 15 {

            // Counterattack
            print("\(defenseCharacter.name) effectue une parade et contre-attaque !")
            attackCharacter.life -= damageDone(atk: defenseCharacter, def: attackCharacter, action: "attack")

        } else if randomNumber > 15 && randomNumber <= 20 {

            // Critical strike
            defenseCharacter.life -= damageDone(atk: attackCharacter, def: defenseCharacter, action: "crit")*2

        } else if randomNumber > 20 && randomNumber <= 100 {

            // Attack
            defenseCharacter.life -= damageDone(atk: attackCharacter, def: defenseCharacter, action: "attack")

        }

        if defenseCharacter.life <= constants.DEAD {

            defenseCharacter.life = constants.DEAD
            print("\(defenseCharacter.name) est mort !")
            print()

        } else if attackCharacter.life <= constants.DEAD {

            attackCharacter.life = constants.DEAD
            print("\(attackCharacter.name) est mort !")
            print()

        }

    } // End of attack()

    func heal() {

        if !attackTeam.canHeal {

            characterPlayed = false

            next()

        } else if attackTeam.canHeal {

            print("\(attackTeam.name) - Quel compagnon souhaites-tu soigner ?")

            healedCharacter = characterChoice(currentTeam: attackTeam)

            if healedCharacter.life == healedCharacter.maxLife {

                print("\(healedCharacter.name) possède déjà tous ses points de vie !")
                print()

                characterPlayed = false

                next()

            } else {

                if healedCharacter.life <= constants.DEAD {

                    print("\(healedCharacter.name) est mort. Veuillez choisir une autre cible !")
                    print()

                } else if healedCharacter.life > constants.DEAD
                    && healedCharacter.life != healedCharacter.maxLife {

                    healedCharacter.life += damageDone(atk: attackCharacter, def: healedCharacter, action: "heal")

                    if healedCharacter.life >= healedCharacter.maxLife {

                        healedCharacter.life = healedCharacter.maxLife

                    }

                    print("Il possède maintenant \(healedCharacter.life) points de vie !")
                    print()

                }

                characterPlayed = true

            }

        }

    } // End of heal()

    func changeWeapon() {

        print("Quelle nouvelle arme choisira \(attackCharacter.name) le \(attackCharacter.roleName) ?"
            + "\n1. Masse - ATQ: \(constants.MACEDAMAGEMIN) à \(constants.MACEDAMAGEMAX) de dégâts"
            + "\n2. Dague - ATQ: \(constants.DAGGERDAMAGEMIN) à \(constants.DAGGERDAMAGEMAX) dégâts"
            + "\n3. Lance - ATQ: \(constants.SPEARDAMAGEMIN) à \(constants.SPEARDAMAGEMAX) dégâts"
            + "\n4. Refuser de changer d'arme")

        var inputweapon: Bool = false

        repeat {

            if let weapon = readLine() {
                switch weapon {
                case "1":
                    inputweapon = true
                    attackCharacter.weapon = Mace()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit d'une imposante masse !")
                case "2":
                    inputweapon = true
                    attackCharacter.weapon = Dagger()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit d'une dague mortelle !")
                case "3":
                    inputweapon = true
                    attackCharacter.weapon = Spear()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit de la lance maniable et rapide !")
                case "4":
                    inputweapon = true
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " refuse de changer d'arme et poursuit le combat !")
                default:
                    inputweapon = false
                    print("Je n'ai pas compris votre choix."
                        + " Veuillez rentrer un numéro pour choisir l'arme correspondante.")
                }

                print()

            }

        } while inputweapon == false

    } // End of chooseWeapon()

    func next() {

        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()

    } // End of next()

} // End of Interractions

// MARK: - End game control
extension Game {

    func deadCharacter() {

        if currentCharacter.life == constants.DEAD {

            isCharacterDead = true
            print("\(currentCharacter.name) est mort. Veuillez sélectionner un autre champion !")

        } else {

            isCharacterDead = false

        }

    } // End of deadCharacter()

    func deadTeam() {

        if defenseTeam.alive == false {

            print("\(attackTeam.name) REMPORTE LA VICTOIRE !!")
            print()

            attackTeam.victory += 1

            isTeamDead = true

        } else if attackTeam.alive == false {

            print("\(defenseTeam.name) REMPORTE LA VICTOIRE !!")
            print()

            defenseTeam.victory += 1

            isTeamDead = true

        } else {

            // Begin of another turn
            isTeamDead = false

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

        print("Que souhaitez-vous faire ?"
            + "\n1. Rejouer avec les mêmes équipes"
            + "\n2. Rejouer avec des équipes différentes"
            + "\n3. Quitter le jeu")

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
