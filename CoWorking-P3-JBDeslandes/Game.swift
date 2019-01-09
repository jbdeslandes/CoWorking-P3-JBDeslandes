//
//  Game.swift
//  CoWorking-P3-JBDeslandes
//
//  Created by Jean-Baptiste Deslandes on 19/09/2018.
//  Copyright © 2018 Jean-Baptiste Deslandes. All rights reserved.
//

import Foundation

// MARK: - GAME PROPERTIES
class Game {

//    To control which team attacks
    var atkTeam: Team!

//    To control which team defends
    var defTeam: Team!

//    Team creation
    var team1 = Team(player: "")
    var team2 = Team(player: "")

//    To not duplicate champion's names
    var memNames: [String] = []

//    To control if a character played
    var characterPlayed: Bool = false

//    To control if a random chest have to appear
    var randomTreasureAppears: Bool = false

//    To control if a character is playable
    var isCharacterPlayable: Bool = false

//    To control when to end game
    var isTeamPlayable: Bool = false

//    To replay with same teams
    var replay: Bool = false

//    To replay from the beginning
    var replayAll: Bool = false

} // End of Game class

// MARK: - GAME
extension Game {

    func mainGame() {

        // CREATE TEAMS
        createPlayers()

        repeat {

            // Reset value
            replayAll = false
            // To create 3 characters for 2 teams
            Message.nameChampions(team1)
            for add in 1...Constants.CHARACTERNUMBER {
                team1.createHero(num: add)
            }

            Message.team1Created(team1)
            Message.next()

            Message.nameChampions(team2)
            for add in 1...Constants.CHARACTERNUMBER {
                team2.createHero(num: add)
            }

            Message.team2Created(team2)
            Message.next()

            // BATTLE MODE
            repeat {

                // reset value
                replay = false
                // Engage teams in battle
                battleMode()
                reset()

            } while replay == true

        } while replayAll == true

    } // End of mainGame()

    func battleMode() {

        randomTeamStart()
        var turn: Int = 0
        // Reset value
        characterPlayed = false

        repeat {

            turn += 1
            Message.turn(turn)

            for _ in 1...2 {

                repeat {
                    atkTeam.currentCharacter.makeDecision()
                    Message.next()
                } while characterPlayed == false

                deadTeam()

                if isTeamPlayable {
                    swap(&atkTeam, &defTeam)
                } else {
                    break
                }
            }

        } while isTeamPlayable == true

        Message.victory(turn, team1, team2)

    } // End of battleMode()

} // End of GAME

// MARK: - Players creation
extension Game {

    func createPlayers() {

        Message.arena()
        Message.playerName(_: "Joueur 1")
        team1 = Team(player: readLine()!)
        Message.welcome1(_: team1.player)

        repeat {
            Message.playerName(_:"Joueur 2")
            team2 = Team(player: readLine()!)

            if team2.player.lowercased() == team1.player.lowercased() {
                Message.usedName()
            }

        } while team1.player.lowercased() == team2.player.lowercased()

        Message.welcome2(_: team2.player)
        Message.next()

    } // End of createPlayer()

} // End of Players creation

// MARK: - Random features
extension Game {

    func randomTeamStart() {

        let choice = Bool.random()

        if choice == true {
            atkTeam = team1
            defTeam = team2
        } else {
            atkTeam = team2
            defTeam = team1
        }

        Message.randomStart(atkTeam)
        Message.next()

    } // End of randomTeamChoice()

    func randomTreasure() {

        // Reset value
        randomTreasureAppears = false

        let randomNumber = Int.random(in: 1...100)

        if randomNumber > 0 && randomNumber <= 10 {
            randomTreasureAppears = true
            Message.randomTreasureAppears()
            Message.next()
            atkTeam.atkCharacter.changeWeapon()
        } else {
            randomTreasureAppears = false
        }

    } // End of randomTreasure()

} // End of Random features

// MARK: - End game control
extension Game {

    func deadCharacter() {

        if atkTeam.currentCharacter.dead == true {
            isCharacterPlayable = false
            Message.deadCharacter(atkTeam.currentCharacter)
        } else {
            isCharacterPlayable = true
        }

    } // End of deadCharacter()

    func deadTeam() {

        if defTeam.alive == false {
            Message.teamWins(atkTeam)
            atkTeam.victory += 1
            isTeamPlayable = false
        } else if atkTeam.alive == false {
            Message.teamWins(defTeam)
            defTeam.victory += 1
            isTeamPlayable = false
        } else {
            // Begin of another turn
            isTeamPlayable = true
        }

    } // End of deadTeam

    func reset() {

        for idk in 1...Constants.TEAMNUMBER {
            switch idk {
            case 1:
                team1.resetLife()
                team1.resetWeapons()
            case 2:
                team2.resetLife()
                team2.resetWeapons()
            default:
                print("Error : func reset1()")
            }

        }

        Message.resetOptions()

        if let choice = readLine() {
            switch choice {
            case "1":
                replay = true
            case "2":
                memNames.removeAll()
                team1.memRoles.removeAll()
                team2.memRoles.removeAll()
                replayAll = true
            case "3":
                print("Merci d'avoir joué !")
            default:
                print("Error : func reset2()")
            }
        }
    }

} // End of End game control
