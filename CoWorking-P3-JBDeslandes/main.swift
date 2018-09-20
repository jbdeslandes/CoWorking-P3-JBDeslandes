//
//  main.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

var character1: Character? = nil
var character2: Character? = nil
var character3: Character? = nil

var currentTeam: Team
var currentCharacter: Character

print("Bienvenue dans l'arène !")
print()

let game = Game()

// PLAYERS CREATION

var team1 = Team(name: "")
var team2 = Team(name: "")

game.createPlayers()

// TEAMS CREATION

print("\(team1.name) - Choisis le nom des héros qui composeront ton équipe !")
print()
