//
//  main.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

var currentCharacter: Character
var attackCharacter: Character
var defenseCharacter: Character
var healedCharacter: Character

var currentTeam: Team
var attackTeam: Team
var defenseTeam: Team

let game = Game()

// PLAYERS CREATION

var team1 = Team(name: "")
var team2 = Team(name: "")

game.mainGame()

// TEAMS CREATION
