//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Game {
    
    func createPlayers() {
        
        print("Joueur 1 - Quel est ton nom ?")
        
        if let player1 = readLine() {
            team1 = Team(name: "\(player1)")
            print("Force & Honneur, \(player1) !")
            print()
        }
        
        print("Joueur 2 - Quel est ton nom ?")
        
        if let player2 = readLine() {
            team2 = Team(name: "\(player2)")
            print("Esprit & Robustesse sur toi, \(player2) !")
            print()
        }
        
    } // End of createPlayer()

    func createHero(currentTeam: Team, characterNum: Int) -> Character {

        print("Quel est le nom de ton champion numéro \(characterNum) ?")
        
        if let hero = readLine() {
            
            print()
            
            print("Quelle sera la classe de \(hero) ?"
                + "\n1. Combattant."
                + "\n2. Magicien."
                + "\n3. Colosse."
                + "\n4. Nain.")
            
            var inputrole: String = ""
            
            repeat {
                
                if let role = readLine() {
                    switch role {
                    case "1":
                        inputrole = "ok"
                        currentCharacter = Character(name: "\(hero)", role: .fighter)
                        print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                    case "2":
                        inputrole = "ok"
                        currentCharacter = Character(name: "\(hero)", role: .wizard)
                        print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                    case "3":
                        inputrole = "ok"
                        currentCharacter = Character(name: "\(hero)", role: .colossus)
                        print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                    case "4":
                        inputrole = "ok"
                        currentCharacter = Character(name: "\(hero)", role: .dwarf)
                        print("La classe de \(currentCharacter.name) sera \(currentCharacter.roleName).")
                    default:
                        inputrole = "ko"
                        print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                    }
                    
                    print()
                    
                }
                
            } while inputrole == "ko"
            
        }
    
        print("Quelle arme brandira \(currentCharacter.name) le \(currentCharacter.roleName) ?"
            + "\n1. Epée."
            + "\n2. Bâton."
            + "\n3. Poings."
            + "\n4. Hache.")
        
        var inputweapon: String = ""
        
        repeat {
            
            if let weapon = readLine() {
                switch weapon {
                case "1":
                    inputweapon = "ok"
                    currentCharacter.weapon = Sword()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit d'une épée tranchante!")
                case "2":
                    inputweapon = "ok"
                    currentCharacter.weapon = Stick()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de son bâton !")
                case "3":
                    inputweapon = "ok"
                    currentCharacter.weapon = Fists()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) n'a besoin d'aucune arme pour écraser ses adversaires !")
                case "4":
                    inputweapon = "ok"
                    currentCharacter.weapon = Axe()
                    print("\(currentCharacter.name) le \(currentCharacter.roleName) se saisit de la hache !")
                default:
                    inputweapon = "ko"
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir l'arme correspondante.")
                }
                
            }
            
        } while inputweapon == "ko"
        
        return currentCharacter
        
    } // End of createTeam()
    
    func play(currentTeam: Team) {
        
        print("\(currentTeam.name) - Quel champion souhaites-tu jouer ?"
            + "\n"
            + "\n1. \(currentTeam.character1!.name) - \(currentTeam.character1!.roleName) - Vie: \(currentTeam.character1!.life)"
            + "\n2. \(currentTeam.character2!.name) - \(currentTeam.character2!.roleName) - Vie: \(currentTeam.character2!.life)"
            + "\n3. \(currentTeam.character3!.name) - \(currentTeam.character3!.roleName) - Vie: \(currentTeam.character3!.life)")
        
        var inputChoice: String = ""
        
        repeat {
        
            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice = "ok"
                    
                case "2":
                    inputChoice = "ok"
                case "3":
                    inputChoice = "ok"
                default:
                    inputChoice = "ko"
                }
                
            }
        
        } while inputChoice == "ko"
    } // End of play()
    
    func takeDamage(attackedTeam: Team) {
        
        print("\(currentTeam.name) - Quel adversaire souhaites-tu attaquer ?"
            + "\n"
            + "\n1. \(attackedTeam.character1!.name) - \(attackedTeam.character1!.roleName) - Vie: \(attackedTeam.character1!.life)"
            + "\n2. \(attackedTeam.character2!.name) - \(attackedTeam.character2!.roleName) - Vie: \(attackedTeam.character2!.life)"
            + "\n3. \(attackedTeam.character3!.name) - \(attackedTeam.character3!.roleName) - Vie: \(attackedTeam.character3!.life)")
        
        var inputChoice: String = ""
        
        repeat {
        
            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice = "ok"
                case "2":
                    inputChoice = "ok"
                case "3":
                    inputChoice = "ok"
                default:
                    inputChoice = "ko"
                }
            }
            
        } while inputChoice == "ko"
    } // End of attackedTeam()
    
} // End of Game class

// Définir func play() dans laquelle on choisit le personnage ? et définir à l'intérieur la func attack()
