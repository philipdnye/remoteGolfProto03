//
//  AddGameViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import SwiftUI

enum AddGameViewFocusable: Hashable {
    case name
    case date
    case club
    case course
    case teebox
}



class AddGameViewModel: ObservableObject {

    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
   
    var name: String = ""
    var date: Date = Date()
    var teeBox: TeeBox = TeeBox()
    var selectedPlayers: [PlayerViewModel] = []

    @Published var pickedClub: Int = 0
    @Published var pickedCourse: Int = 0
    @Published var pickedTeeBox: Int = 0
    
    
    
    
    @Published var pickerScoringFormat: ScoreFormat = .medal
    @Published var pickerHandicapFormat: HandicapFormat = .handicap

    @Published var pickerGameFormat: GameFormatType = .fourBallBBMatch

    @Published var pickerStartingHole: Int = 1
    @Published var pickerGameDuration: Int = 1
    
    
    
    @Published var newTeeBox: TeeBox = TeeBox()

    func AssignCompetitorTeams(game: Game) {
        switch currentGF.assignTeamGrouping {
        case .Indiv:
            for i in 0..<(game.competitorArray.count) {
                game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
            }
        case .TeamsAB:
            switch currentGF.noOfPlayersNeeded {
            case 4:
                for i in 0..<(game.competitorArray.count) {
                    switch i {
                    case 0:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    case 1:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    case 2:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                    case 3:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                    default:
                        game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
                    }
                }
            case 2:
                for i in 0..<(game.competitorArray.count)    {
                    switch i {
                    case 0:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
                    case 1:
                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
                    default:
                        game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
                    }
                }
            default:
                game.competitorArray[0].team = Int16(TeamAssignment.indiv.rawValue)
            }
        case .TeamC:
            for i in 0..<(game.competitorArray.count) {
                game.competitorArray[i].team = Int16(TeamAssignment.teamC.rawValue)
            }
        }
    }
    
    func AssignPlayingHandicaps (game: Game) {
        switch currentGF.competitorSort {
        case .TeamsAB:
            
            func TeamABLowHigh (competitors: [Competitor]) -> (teamALow:Competitor, teamAHigh: Competitor, teamBLow: Competitor, teamBHigh: Competitor){
                let teamA = competitors.filter({$0.team == TeamAssignment.teamA.rawValue})
                let teamB = competitors.filter({$0.team == TeamAssignment.teamB.rawValue})
                let teamAHigh = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.max()})
                let teamBHigh = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.max()})
                let teamALow = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.min()})
                let teamBLow = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.min()})
                
                return (teamALow[0], teamAHigh[0], teamBLow[0], teamBHigh[0])
            }
            
            
            switch currentGF.noOfPlayersNeeded{
            case 4:
                let teamALowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamALow.id})
                let teamAHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamAHigh.id})
                let teamBLowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBLow.id})
                let teamBHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBHigh.id})
                
                game.competitorArray[teamALowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[0]
                game.competitorArray[teamAHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[1]
                game.competitorArray[teamBLowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[2]
                game.competitorArray[teamBHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[3]
                
                
            case 2:
                for i in 0..<game.competitorArray.count {
                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
                }
            default:
                for i in 0..<game.competitorArray.count {
                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
                }
            }
        case .Indiv:
            for i in 0..<game.competitorArray.count {
                game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
            }
            
        case .TeamC:
            let sortedCompetitors = game.competitorArray.sorted(by: {$0.handicapIndex < $1.handicapIndex})
            
            for i in 0..<sortedCompetitors.count {
                sortedCompetitors[i].handicapAllowance = currentGF.playerHandAllowances[i]
            }
        }
        // NOW ASSIGN THE PLAYING HANDICAP
        for i in 0..<game.competitorArray.count {
            game.competitorArray[i].playingHandicap = game.competitorArray[i].courseHandicap * game.competitorArray[i].handicapAllowance
        }
    }
    
    
    
    
}

