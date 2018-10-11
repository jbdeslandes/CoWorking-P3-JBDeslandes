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
    
    private var isTeamDead: Bool = false
//    To control how to end game
    
    private var memNames: [String] = []
//    To not duplicate champion's names
    
    func createPlayers() {
        
        print("Joueur 1 - Quel est ton nom ?", terminator: "")
        
        if let player1 = readLine() {
            team1 = Team(name: "\(player1)")
            print("Force & Honneur, \(player1) !")
            print()
        }
        
        print("Joueur 2 - Quel est ton nom ?", terminator: "")
        
        if let player2 = readLine() {
            team2 = Team(name: "\(player2)")
            print("Esprit & Robustesse sur toi, \(player2) !")
            print()
        }
        
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
       
            //            hero = Passer la première lettre en majuscule) :Uppercase first ?
            
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
                    print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                case "2":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .wizard)
                    print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                case "3":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .colossus)
                    print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                case "4":
                    inputrole = true
                    currentCharacter = Character(name: "\(hero)", role: .dwarf)
                    print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                default:
                    inputrole = false
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                    
                print()
                    
            }
                
        } while inputrole == false
        
        
        print("Quelle arme brandira \(currentCharacter.name) le \(currentCharacter.roleName) ?"
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
                    currentCharacter.weapon = Sword()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit d'une épée tranchante!")
                case "2":
                    inputweapon = true
                    currentCharacter.weapon = Stick()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de son bâton !")
                case "3":
                    inputweapon = true
                    currentCharacter.weapon = Fists()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) n'a besoin d'aucune arme pour écraser ses adversaires !")
                case "4":
                    inputweapon = true
                    currentCharacter.weapon = Axe()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de la hache !")
                default:
                    inputweapon = false
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir l'arme correspondante.")
                }
                
                print()
                
            }
            
        } while inputweapon == false
        
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
        
        repeat {
            
            turn += 1
        
            print("TOUR \(turn)")
            print()
            
            print("\(attackTeam.name) - Quel champion souhaites-tu jouer ?")
            
            attackCharacter = characterChoice(currentTeam: attackTeam)
            
            print("\(attackTeam.name) - Quel adversaire \(currentCharacter.name) doit-il attaquer ?")
            
            defenseCharacter = characterChoice(currentTeam: defenseTeam)

            attack()
            
            deadTeam()
            
            if !isTeamDead {
                
                swap(&attackTeam, &defenseTeam)
                
            }
            
        } while isTeamDead == false
      
        print("FIN DU COMBAT")
        
    } // End of play()
    
    func attack() {
        
        defenseCharacter.life = defenseCharacter.life - attackCharacter.weapon!.damage
        print("\(attackCharacter.name) inflige \(attackCharacter.weapon!.damage) points de dégats à \(defenseCharacter.name) !")
        print()
        
        if defenseCharacter.life <= DEAD {
            defenseCharacter.life = DEAD
            print("\(defenseCharacter.name) est mort !")
            print()
        }
        
    } // End of attack()
    
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
    
} // End of Game class


// - Fonction switch les équipes en postion d'attaque / défense jusqu'au message de victoire.

