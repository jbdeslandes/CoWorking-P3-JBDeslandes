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

    func createTeam() {
        
        print("Quel est le nom de ton premier 1er champion ?")
        
        if let hero1 = readLine() {
            team1.character1 = Character(name: "\(hero1)", role: .fighter)
            print()
            print("Quelle sera la classe de \(hero1) ?"
                + "\n1. Combattant."
                + "\n2. Magicien."
                + "\n3. Colosse."
                + "\n4. Nain.")
        }
        
        var inputrole1: String = ""
        
        repeat {
            
            if let role1 = readLine() {
                switch role1 {
                case "1":
                    inputrole1 = "ok"
                    team1.character1!.role = .fighter
                    print("La classe de \(team1.character1!.name) sera Combattant.")
                case "2":
                    inputrole1 = "ok"
                    team1.character1!.role = .wizard
                    print("La classe de \(team1.character1!.name) sera Magicien.")
                case "3":
                    inputrole1 = "ok"
                    team1.character1!.role = .colossus
                    print("La classe de \(team1.character1!.name) sera Colosse.")
                case "4":
                    inputrole1 = "ok"
                    team1.character1!.role = .dwarf
                    print("La classe de \(team1.character1!.name) sera Nain.")
                default:
                    inputrole1 = "ko"
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir la classe correspondante.")
                }
                print()
            }
            
        } while inputrole1 == "ko"
        
        print("Quelle arme brandira \(team1.character1!.name) le \(team1.character1!.roleName) ?"
            + "\n1. Epée."
            + "\n2. Bâton."
            + "\n3. Poings."
            + "\n4. Hache.")
        
        var inputweapon1: String = ""
        
        repeat {
            
            if let weapon1 = readLine() {
                switch weapon1 {
                case "1":
                    inputweapon1 = "ok"
                    team1.character1!.weapon = Sword()
                    print("\(team1.character1!.name) le \(team1.character1!.roleName) se saisit d'une épée et rentre dans l'arène !")
                case "2":
                    inputweapon1 = "ok"
                    team1.character1!.weapon = Stick()
                    print("\(team1.character1!.name) le \(team1.character1!.roleName) se saisit de son bâton et rentre dans l'arène !")
                case "3":
                    inputweapon1 = "ok"
                    team1.character1!.weapon = Fists()
                    print("\(team1.character1!.name) le \(team1.character1!.roleName) n'a besoin d'aucune arme pour écraser ses adversaires, et se rue dans l'arène !")
                case "4":
                    inputweapon1 = "ok"
                    team1.character1!.weapon = Axe()
                    print("\(team1.character1!.name) le \(team1.character1!.roleName) se saisit de la hache et rentre dans l'arène !")
                default:
                    inputweapon1 = "ko"
                    print("Je n'ai pas compris votre choix. Veuillez rentrer un numéro pour choisir l'arme correspondante.")
                }
                
            }
            
        } while inputweapon1 == "ko"
        
    } // End of createTeam()
}


// Factoriser le code.

// Corriger le problème de blocage sur "Combattant" dans role.

// Ajouter une phrase qui confirme les trois membres de l'équipe 1, et passer à l'équipe 2.
