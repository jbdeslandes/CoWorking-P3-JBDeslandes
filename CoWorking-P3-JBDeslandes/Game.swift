//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

class Game {
    
    var team1 = Team(name: "")
    var team2 = Team(name: "")
    
    
    var character1: Character? = nil
    var character2: Character? = nil
    var character3: Character? = nil

    func createTeams() {
        
        //      Noms des joueurs :
        
        
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
        
        //        Team 1 : Création du 1er personnage :
        
        
        print("\(team1.name) - Choisis le nom des héros qui composeront ton équipe !")
        print()
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
        
    }
}
