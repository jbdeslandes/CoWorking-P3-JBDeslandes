//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Game {
    
    private var memNames: [String] = []
//    To not duplicate champion's names
    
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
        
        var hero: String = ""
        
        var duplicate: Bool = false

        print("Quel est le nom de ton champion numéro \(characterNum) ?")
        
        repeat {
        
            hero = readLine()!
            
            duplicate = false
                
                for i in 0..<memNames.count {
                    if hero == memNames[i] {
                        duplicate = true
                    }
                }
            
                if duplicate == true {
                    print()
                    print("Ce nom est déjà pris, veuillez recommencer.")
                }
            
        } while duplicate == true
        
        memNames.append(hero)
//        Hero's name added
        
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
    
    func play(playingTeam: Team, waitingTeam: Team) {
        
        attackTeam = playingTeam
        defenseTeam = waitingTeam

        print("\(attackTeam.name) - Quel champion souhaites-tu jouer ?"
            + "\n"
            + "\n1. \(attackTeam.character1!.name) - \(attackTeam.character1!.roleName) - Vie: \(attackTeam.character1!.life)"
            + "\n2. \(attackTeam.character2!.name) - \(attackTeam.character2!.roleName) - Vie: \(attackTeam.character2!.life)"
            + "\n3. \(attackTeam.character3!.name) - \(attackTeam.character3!.roleName) - Vie: \(attackTeam.character3!.life)")
        
//        Incorporer la cible
        
        var inputChoice1: Bool = false
        
        repeat {
        
            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice1 = true
                    currentCharacter = attackTeam.character1!
                case "2":
                    inputChoice1 = true
                    currentCharacter = attackTeam.character2!
                case "3":
                    inputChoice1 = true
                    currentCharacter = attackTeam.character3!
                default:
                    inputChoice1 = false
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                
            }
        
        } while inputChoice1 == false
        
        print("\(attackTeam.name) - Quel adversaire \(currentCharacter.name) doit-il attaquer ?"
            + "\n"
            + "\n1. \(defenseTeam.character1!.name) - \(defenseTeam.character1!.roleName) - Vie: \(defenseTeam.character1!.life)"
            + "\n2. \(defenseTeam.character2!.name) - \(defenseTeam.character2!.roleName) - Vie: \(defenseTeam.character2!.life)"
            + "\n3. \(defenseTeam.character3!.name) - \(defenseTeam.character3!.roleName) - Vie: \(defenseTeam.character3!.life)")
        
        var inputChoice2: Bool = false
        
        repeat {
            
            if let choice = readLine() {
                switch choice {
                case "1":
                    inputChoice2 = true
                    defenseCharacter = defenseTeam.character1!
                    attack()
                case "2":
                    inputChoice2 = true
                    defenseCharacter = defenseTeam.character2!
                    attack()
                case "3":
                    inputChoice2 = true
                    defenseCharacter = defenseTeam.character3!
                    attack()
                default:
                    inputChoice2 = false
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                print()
            }
            
        } while inputChoice2 == false
        
    } // End of play()
    
    func attack() {
        
        let minimumLife = 0
        
        defenseCharacter.life = defenseCharacter.life - currentCharacter.weapon!.damage
        print("\(currentCharacter.name) inflige \(currentCharacter.weapon!.damage) dégats à \(defenseCharacter.name) !")
        
        
        if defenseCharacter.life <= minimumLife {
            defenseCharacter.life = minimumLife
            print("\(defenseCharacter.name) est mort !")
        }
        
//        Incorporer if character is dead
        
    } // End of attack()
    
} // End of Game class

/* - Afficher un message d'erreur et revenir au choix des cibles à attaquer lorsqu'un personnage est mort.
   - Détecter lorsque tous les personnages d'une équipe sont morts et afficher le message de fin de partie.
   - Organiser play() autour d'un paramètre "tour", pour que la fonction switch les équipes en postion d'attaque / défense, et passe automatiquement au tour suivant jusqu'au message de victoire. */
