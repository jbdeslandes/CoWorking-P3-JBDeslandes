//
//  main.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

var currentCharacter: Character
var attackCharacter : Character
var defenseCharacter: Character
var healedCharacter: Character

var currentTeam: Team
var attackTeam: Team
var defenseTeam: Team

let game = Game()

// PLAYERS CREATION

var team1 = Team(name: "")
var team2 = Team(name: "")

game.createPlayers()

// TEAMS CREATION

print("\(team1.name) - Choisis le nom des héros qui composeront ton équipe !")
print()

currentCharacter = game.createHero(currentTeam: team1, characterNum: 1)
team1.character1 = currentCharacter

currentCharacter = game.createHero(currentTeam: team1, characterNum: 2)
team1.character2 = currentCharacter

currentCharacter = game.createHero(currentTeam: team1, characterNum: 3)
team1.character3 = currentCharacter

print("\(team1.name) - Tes champions \(team1.character1!.name), \(team1.character2!.name) et \(team1.character3!.name) atteignent l'arène et attendent leurs adversaires de pied ferme..")
print()

print("\(team2.name) - A toi maintenant de choisir le nom des héros qui composeront ton équipe !")
print()

currentCharacter = game.createHero(currentTeam: team2, characterNum: 1)
team2.character1 = currentCharacter

currentCharacter = game.createHero(currentTeam: team2, characterNum: 2)
team2.character2 = currentCharacter

currentCharacter = game.createHero(currentTeam: team2, characterNum: 3)
team2.character3 = currentCharacter

print("\(team2.name) - Tes champions \(team2.character1!.name), \(team2.character2!.name) et \(team2.character3!.name) rejoignent l'enceinte et font face à leurs rivaux..")
print()

// BATTLE MODE

game.play()

