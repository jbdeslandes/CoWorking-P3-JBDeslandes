//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Game {
    
    private var isCharacterDead: Bool = false
//    To control if a character is playable
    
    private var characterPlayed: Bool = false
//    To control if a character can be heal
    
    private var isTeamDead: Bool = false
//    To control how to end game
    
    private var memePlayersName: [String] = []
//    To not duplicate player's names
    
    private var memNames: [String] = []
//    To not duplicate champion's names
    
    func createPlayers() {

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

    func createHero(currentTeam: Team, characterNum: Int) -> Character {
        
        var hero: String = ""
        
        var duplicate: Bool = false

        print("Quel est le nom de ton champion numéro \(characterNum) ?")
        
        repeat {
        
            hero = readLine()!
            
            duplicate = false
                
                for i in 0..<memNames.count {
                    if hero.lowercased() == memNames[i] {
                        duplicate = true
                    }
                }
            
                if duplicate == true {
                    print()
                    print("Ce nom est déjà pris, veuillez recommencer.")
                }
            
        } while duplicate == true
        
        memNames.append(hero.lowercased())
//        Hero's name added to memory
        
        print()
            
        print("Quelle sera la classe de \(hero) ?"
            + "\n1. Combattant."
            + "\n2. Magicien."
            + "\n3. Colosse."
            + "\n4. Nain.")
            
        var inputrole: Bool = false
            
        repeat {
                
            if let role = readLine() {
                switch role {
                case "1":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .fighter)
                    currentCharacter.weapon = Sword()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) attrape une épée tranchante dans le râtelier d'arme le plus proche !")
                case "2":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .wizard)
                    currentCharacter.weapon = Stick()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) invoque son septre magique !")
                case "3":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .colossus)
                    currentCharacter.weapon = Fists()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) n'a besoin d'aucune arme pour écraser ses adversaires !")
                case "4":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .dwarf)
                    currentCharacter.weapon = Axe()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de sa hache préférée !")
                default:
                    inputrole = false
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                    
                print()
                    
            }
                
        } while inputrole == false
        
        return currentCharacter
        
    } // End of createHero()
    
    func randomTeamChoice() {
        
       let Choice = Bool.random()
        
        if Choice == true {
            
            attackTeam = team1
            defenseTeam = team2
            
        } else {
            
            attackTeam = team2
            defenseTeam = team1
            
        }
        
        print("Le peuple a parlé ! L'équipe de \(attackTeam.name) donnera le premier assaut !")
        print()
    
    } // End of randomTeamChoice()
    
    func play() {
        
        var turn: Int = 0
        
        characterPlayed = false
        
        repeat {
            
            turn += 1
        
            print("--- TOUR \(turn) ---")
            print()

            repeat {
            
                makeDecision()
                
            } while characterPlayed == false
            
            deadTeam()
            
            if !isTeamDead {
                
                swap(&attackTeam, &defenseTeam)
                
            } // First player's move
            
            repeat {
                
                makeDecision()
                
            } while characterPlayed == false
            
            deadTeam()
            
            if !isTeamDead {
                
                swap(&attackTeam, &defenseTeam)
                
            } // Second player's move
            
        } while isTeamDead == false
      
        print("FIN DU COMBAT")
        
    } // End of play()
    
    func attack() {
        
        let randomNumber = Int.random(in: 1...100)
        
        if randomNumber > 0 && randomNumber <= 10 {
            
            print("\(defenseCharacter.name) esquive l'assaut !")
            print()
            
            // Dodge
            
        } else if randomNumber > 10 && randomNumber <= 15 {
            
            attackCharacter.life = attackCharacter.life - defenseCharacter.weapon!.damage
            print("\(defenseCharacter.name) effectue une parade et contre-attaque !")
            print()
            
            // Counter attack
            
        } else if randomNumber > 15 && randomNumber <= 20 {
            
            defenseCharacter.life = defenseCharacter.life - (attackCharacter.weapon!.damage * 2)
            print("\(attackCharacter.name) trouve une faille dans la défense de \(defenseCharacter.name) et lui assène un coup critique !!")
            print()
            
            // Critical strike
            
        } else if randomNumber > 20 && randomNumber <= 100 {
        
            defenseCharacter.life = defenseCharacter.life - attackCharacter.weapon!.damage
            print("\(attackCharacter.name) inflige \(attackCharacter.weapon!.damage) points de dégats à \(defenseCharacter.name) !")
            print()
            
            // To attack
        
        }
        
        if defenseCharacter.life <= DEAD {
            
            defenseCharacter.life = DEAD
            print("\(defenseCharacter.name) est mort !")
            print()
            
        }
        
    } // End of attack()
    
    func heal() {
        
        if healedCharacter.life <= DEAD {
            
            print("\(healedCharacter.name) est mort. Veuillez choisir une autre cible !")
            
        } else if healedCharacter.life > DEAD && healedCharacter.life != healedCharacter.maxLife {
                
                 healedCharacter.life = healedCharacter.life + attackCharacter.weapon!.damage
            
                print("\(healedCharacter.name) reçoit un soin de \(attackCharacter.name). Il possède maintenant \(healedCharacter.life) points de vie !")
                
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
    
    func makeDecision() {
        
        print("\(attackTeam.name) - Quel champion souhaites-tu jouer ?")
        
        attackCharacter = characterChoice(currentTeam: attackTeam)
        
        if attackCharacter.role == .wizard {
            
            characterPlayed = false
            
            if attackTeam.character1!.life == attackTeam.character1!.maxLife && attackTeam.character2!.life == attackTeam.character2!.maxLife && attackTeam.character3!.life == attackTeam.character3!.maxLife {
                
                print("Tous tes champions possèdent déjà leur santé au maximum !")
                print()
                
                next()
                
            } else {
                
                print("\(attackTeam.name) - Quel compagnon souhaites-tu soigner ?")
                
                healedCharacter = characterChoice(currentTeam: attackTeam)
                
                heal()
                
                characterPlayed = true
                
            }
            
        } else {
            
            print("\(attackTeam.name) - Quel adversaire souhaites-tu attaquer ?")
            
            defenseCharacter = characterChoice(currentTeam: defenseTeam)
            
            attack()
            
            characterPlayed = true
            
        }
        
    } // End of makeDecision()
    
    func deadCharacter() {
        
        if currentCharacter.life == DEAD {
            
            isCharacterDead = true
            print("\(currentCharacter.name) est mort. Veuillez sélectionner un autre champion !")
            
        } else {
            
            isCharacterDead = false
            
        }

    } // End of deadCharacter()
    
    func deadTeam() {
        
        if defenseTeam.character1!.life == DEAD && defenseTeam.character2!.life == DEAD && defenseTeam.character3!.life == DEAD {
            
            isTeamDead = true
            print("Tous les champions de \(defenseTeam.name) sont morts !")
            print()
            
        } else {
         
            isTeamDead = false
            
        }
        
        next()
        
    } // End of deadTeam
    
    func characterChoice(currentTeam: Team) -> Character {
        
        print("\n1. \(currentTeam.character1!.name) - \(currentTeam.character1!.roleName) - Vie: \(currentTeam.character1!.life)"
            + "\n2. \(currentTeam.character2!.name) - \(currentTeam.character2!.roleName) - Vie: \(currentTeam.character2!.life)"
            + "\n3. \(currentTeam.character3!.name) - \(currentTeam.character3!.roleName) - Vie: \(currentTeam.character3!.life)")
        
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
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                
                deadCharacter()
                
            }
            
        } while inputChoice1 == false || isCharacterDead == true
        
        return currentCharacter
        
    } // End of characterChoice()
    
    func randomTreasure() {
        
//        print("Quelle arme brandira \(currentCharacter.name) le \(currentCharacter.roleName) ?"
//            + "\n1. Epée."
//            + "\n2. Bâton."
//            + "\n3. Poings."
//            + "\n4. Hache.")
//
//        var inputweapon: Bool = false
//
//        repeat {
//
//            if let weapon = readLine() {
//                switch weapon {
//                case "1":
//                    inputweapon = true
//                    currentCharacter.weapon = Sword()
//                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit d'une épée tranchante!")
//                case "2":
//                    inputweapon = true
//                    currentCharacter.weapon = Stick()
//                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de son bâton !")
//                case "3":
//                    inputweapon = true
//                    currentCharacter.weapon = Fists()
//                    print("\(currentCharacter.name) le \(currentCharacter.roleName) n'a besoin d'aucune arme pour écraser ses adversaires !")
//                case "4":
//                    inputweapon = true
//                    currentCharacter.weapon = Axe()
//                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de la hache !")
//                default:
//                    inputweapon = false
//                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir l'arme correspondante.")
//                }
//
//                print()
//
//            }
//
//        } while inputweapon == false
        
    } // End of randomTreasure()
    
} // End of Game class


/*
 
 I - COMPLETER :
 
 - Incorporer le coffre des armes (début de combat ou un round ?)
 - Incorporer des ajouts comme esquives & coups critiques
 - Incorporer un ajout arme poison (dégats minimes sur trois tours) ?
 
 II - AFFINER :
 
  - faire disparaitre les optionnels à terme pour if let / guard (sous réserve qu’il existe, le reste s’exécute)
 
 - TEAMS CREATION (plus tard Tableau d'objets pour éviter les répétitions)
 
 */

