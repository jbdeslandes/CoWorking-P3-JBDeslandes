//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Game {

//    To control if a character is playable
    private var isCharacterDead: Bool = false

//    To control if a character can be heal
    private var characterPlayed: Bool = false

//    To control if a random chest have to appear
    private var randomTreasureAppears: Bool = false

//    To control when to end game
    private var isTeamDead: Bool = false

//    To not duplicate player's names
    private var memePlayersName: [String] = []

//    To name Characters
    private var hero: String = ""

//    To not duplicate champion's names
    private var memNames: [String] = []

} // End of Game class

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

            if player2 == player1 {

                print("Ce nom est déjà pris, veuillez recommencer.")
                print()

            }

        } while player1.lowercased() == player2.lowercased()

        team2 = Team(name: "\(player2)")
        print("Esprit & Robustesse sur toi, \(player2) !")
        print()

        next()

    } // End of createPlayer()

    func createHero(team: Team, num: Int) -> Character {

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
                    print()
                    print("Ce nom est déjà pris, veuillez recommencer.")
                }

        } while duplicate == true

        //        Hero's name added to memory
        memNames.append(hero.lowercased())

        print()

        print("Quelle sera la classe de \(hero) ?"
            + "\n1. Combattant."
            + "\n2. Magicien."
            + "\n3. Colosse."
            + "\n4. Nain.")

        selectRole()

        return currentCharacter

    } // End of createHero()

    func selectRole() {

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
                        + "Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }

                print()

            }

        } while inputrole == false

    } // End of selectRole()

} // End of Teams Creation

// MARK: - Battle mode
extension Game {

    func play() {

        randomTeamChoice()

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

                } while characterPlayed == false

                deadTeam()

                if !isTeamDead {

                    swap(&attackTeam, &defenseTeam)

                } else {

                    print ("L'équipe de \(defenseTeam.name) est morte !")
                    print()
                    break

                }

            }

        } while isTeamDead == false

        print("FIN DU COMBAT")

    } // End of play()

} // End of Battle Mode

// MARK: - Interractions
extension Game {

    func characterChoice(currentTeam: Team) -> Character {

        print("\n1. \(currentTeam.character1!.name)"
            + " - \(currentTeam.character1!.roleName)"
            + " - Vie: \(currentTeam.character1!.life)"

            + "\n2. \(currentTeam.character2!.name)"
            + " - \(currentTeam.character2!.roleName)"
            + " - Vie: \(currentTeam.character2!.life)"

            + "\n3. \(currentTeam.character3!.name)"
            + " - \(currentTeam.character3!.roleName)"
            + " - Vie: \(currentTeam.character3!.life)")

        var inputChoice1: Bool = false

        repeat {

            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice1 = true
                    currentCharacter = currentTeam.character1!
                case "2":
                    inputChoice1 = true
                    currentCharacter = currentTeam.character2!
                case "3":
                    inputChoice1 = true
                    currentCharacter = currentTeam.character3!
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

        repeat {

            // Reset value
            characterPlayed = false

            print("\(attackTeam.name) - Quel champion souhaites-tu jouer ?")

            attackCharacter = characterChoice(currentTeam: attackTeam)

            if attackCharacter.role == .wizard {

                if attackTeam.character1!.life == attackTeam.character1!.maxLife
                    && attackTeam.character2!.life == attackTeam.character2!.maxLife
                    && attackTeam.character3!.life == attackTeam.character3!.maxLife {

                    print("Tous tes champions possèdent déjà leur santé au maximum !")
                    print()

                    characterPlayed = false

                    next()

                } else {

                    print("\(attackTeam.name) - Quel compagnon souhaites-tu soigner ?")

                    healedCharacter = characterChoice(currentTeam: attackTeam)

                    heal()

                    characterPlayed = true

                }

            } else {

                randomTreasure()

                print("\(attackTeam.name) - Quel adversaire souhaites-tu attaquer ?")

                defenseCharacter = characterChoice(currentTeam: defenseTeam)

                attack()

                characterPlayed = true

            }

        } while characterPlayed == false

    } // End of makeDecision()

    func attack() {

        // Generating random number
        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {

            // Dodge
            print("\(defenseCharacter.name) esquive l'assaut !")
            print()

        } else if randomNumber > 10 && randomNumber <= 15 {

            // Counter attack
            attackCharacter.life -= defenseCharacter.weapon!.damage
            print("\(defenseCharacter.name) effectue une parade et contre-attaque !")
            print()

        } else if randomNumber > 15 && randomNumber <= 20 {

            // Critical strike
            defenseCharacter.life -= (attackCharacter.weapon!.damage * 2)
            print("\(attackCharacter.name) trouve une faille dans la défense de"
                + " \(defenseCharacter.name) et lui assène un coup critique !!")
            print()

        } else if randomNumber > 20 && randomNumber <= 100 {

            // Attack
            defenseCharacter.life -= attackCharacter.weapon!.damage
            print("\(attackCharacter.name) inflige \(attackCharacter.weapon!.damage)"
                + " points de dégats à \(defenseCharacter.name) !")
            print()

        }

        if defenseCharacter.life <= DEAD {

            defenseCharacter.life = DEAD
            print("\(defenseCharacter.name) est mort !")
            print()

        } else if attackCharacter.life <= DEAD {

            attackCharacter.life = DEAD
            print("\(attackCharacter.name) est mort !")
            print()

        }

    } // End of attack()

    func heal() {

        if healedCharacter.life <= DEAD {

            print("\(healedCharacter.name) est mort. Veuillez choisir une autre cible !")

        } else if healedCharacter.life > DEAD && healedCharacter.life != healedCharacter.maxLife {

                 healedCharacter.life += attackCharacter.weapon!.damage

                print("\(attackCharacter.name) soigne"
                    + " \(healedCharacter.name). Il possède maintenant \(healedCharacter.life) points de vie !")

                if healedCharacter.life > healedCharacter.maxLife {

                    healedCharacter.life = healedCharacter.maxLife
                    print("\(healedCharacter.name) est au sommet de sa forme !")
                    print()

                }

        } else if healedCharacter.life == healedCharacter.maxLife {

            print("La santé de \(healedCharacter.name) est déjà au maximum !")
            print()

        }

    } // End of func heal()

    func next() {

        print("Appuyer sur Entrer pour continuer..")
        _ = readLine()

    } // End of func next()

} // End of Interractions

// MARK: - Random features
extension Game {

    func randomTeamChoice() {

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

            chooseWeapon()

        } else {

            randomTreasureAppears = false

        }

    } // End of randomTreasure()

    func chooseWeapon() {

        print("Quelle nouvelle arme choisira \(attackCharacter.name) le \(attackCharacter.roleName) ?"
            + "\n1. Epée."
            + "\n2. Bâton."
            + "\n3. Poings."
            + "\n4. Hache.")

        var inputweapon: Bool = false

        repeat {

            if let weapon = readLine() {
                switch weapon {
                case "1":
                    inputweapon = true
                    attackCharacter.weapon = Sword()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit d'une épée tranchante!")
                case "2":
                    inputweapon = true
                    attackCharacter.weapon = Stick()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit du bâton !")
                case "3":
                    inputweapon = true
                    attackCharacter.weapon = Fists()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " n'a besoin d'aucune arme pour écraser ses adversaires !")
                case "4":
                    inputweapon = true
                    attackCharacter.weapon = Axe()
                    print("\(attackCharacter.name) le \(attackCharacter.roleName)"
                        + " se saisit de la hache !")
                default:
                    inputweapon = false
                    print("Je n'ai pas compris votre choix."
                        + " Veuillez rentrer un numéro pour choisir l'arme correspondante.")
                }

                print()

            }

        } while inputweapon == false

    } // End of func chooseWeapon()

} // End of Random features

// MARK: - End game control
extension Game {

    func deadCharacter() {

        if currentCharacter.life == DEAD {

            isCharacterDead = true
            print("\(currentCharacter.name) est mort. Veuillez sélectionner un autre champion !")

        } else {

            isCharacterDead = false

        }

    } // End of deadCharacter()

    func deadTeam() {

        if defenseTeam.character1!.life == DEAD
            && defenseTeam.character2!.life == DEAD
            && defenseTeam.character3!.life == DEAD {

            isTeamDead = true
            print("Tous les champions de \(defenseTeam.name) sont morts !")
            print()

        } else {

            isTeamDead = false

        }

        next()

    } // End of deadTeam

} // End of End game control

/*
 I - COMPLETER :
 - Simplifer createHero -> Main via for 3
 - Problème apperçu dans heal un personnage / vie max
 - Incorporer abandon si le mage est le seul survivant.
 - Incorporer un ajout arme poison (dégats minimes sur trois tours) ?
 
 II - AFFINER :
  - faire disparaitre les optionnels à terme pour if let / guard (sous réserve qu’il existe, le reste s’exécute)
 */
