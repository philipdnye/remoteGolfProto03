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
    
//    func updateCurrentGameFormat (currentGF: CurrentGameFormat,gameFormat: GameFormatType) {
//        currentGF.id = gameFormats[gameFormat.rawValue].id
//        currentGF.format = gameFormats[gameFormat.rawValue].format
//        currentGF.description = gameFormats[gameFormat.rawValue].description
//        currentGF.noOfPlayersNeeded = gameFormats[gameFormat.rawValue].noOfPlayersNeeded
//        currentGF.playerHandAllowances = gameFormats[gameFormat.rawValue].playerHandAllowances
//        currentGF.assignShotsRecd = gameFormats[gameFormat.rawValue].assignShotsRecd
//        currentGF.assignTeamGrouping = gameFormats[gameFormat.rawValue].assignTeamGrouping
//        currentGF.competitorSort = gameFormats[gameFormat.rawValue].competitorSort
//        currentGF.playFormat = gameFormats[gameFormat.rawValue].playFormat
//        currentGF.extraShotsTeamAdj = gameFormats[gameFormat.rawValue].extraShotsTeamAdj
//        currentGF.bogey = gameFormats[gameFormat.rawValue].bogey
//        currentGF.medal = gameFormats[gameFormat.rawValue].medal
//        currentGF.stableford = gameFormats[gameFormat.rawValue].stableford
//        
//        print("id: \(currentGF.id)")
//        print("format: \(currentGF.format)")
//        print("description: \(currentGF.description)")
//        print("noOFPlayers: \(currentGF.noOfPlayersNeeded)")
//        print("playerHandAllowances: \(currentGF.playerHandAllowances)")
//        print("assignShotsRecd: \(currentGF.assignShotsRecd)")
//        print("competitorSort: \(currentGF.competitorSort)")
//        print("playFormat: \(currentGF.playFormat)")
//        print("extraShots: \(currentGF.extraShotsTeamAdj)")
//        print("Stableford: \(currentGF.stableford)")
//        print("Medal: \(currentGF.medal)")
//        print("Bogey: \(currentGF.bogey)")
//    }
    
    
   
    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
   
    var name: String = ""
    var date: Date = Date()
    var teeBox: TeeBox = TeeBox()
    var selectedPlayers: [PlayerViewModel] = []

    
//    var gameDetail_HandicapFormat: Int16 = 0
//    var gameDetail_ScoreFormat: Int16 = 0
//    var gameDetail_GameFormat: Int16 = 0
    
    @Published var pickedClub: Int = 0
    @Published var pickedCourse: Int = 0
    @Published var pickedTeeBox: Int = 0
    
    
    
    
    @Published var pickerScoringFormat: ScoreFormat = .medal
    @Published var pickerHandicapFormat: HandicapFormat = .handicap
//    @Published var pickerPlayFormat: PlayFormat = .strokeplay
    @Published var pickerGameFormat: GameFormatType = .fourBallBBMatch

    @Published var newTeeBox: TeeBox = TeeBox()
//    func createGame() {
//           
//            let manager = CoreDataManager.shared
//            let game = Game(context: manager.persistentContainer.viewContext)
//            
//            game.name = name
//            game.date = date
//            game.defaultTeeBox = teeBox
//            game.gameFormat = Int16(pickerGameFormat.rawValue)
//        
//                for player in selectedPlayers {
//                    let competitor = Competitor(context: manager.persistentContainer.viewContext)
//                    competitor.player = player.player
//                    competitor.game = game
//                    competitor.teeBox = game.defaultTeeBox
//                    competitor.handicapIndex = player.player.handicapArray.currentHandicapIndex()
//                    competitor.courseHandicap = competitor.CourseHandicap()
//                    player.player.selectedForGame.toggle()
//                }
//           
//            game.scoreFormat = Int16(pickerScoringFormat.rawValue)
//            game.handicapFormat = Int16(pickerHandicapFormat.rawValue)
//           
//        manager.save()
//       
//        currentGF.id = gameFormats[Int(game.gameFormat)].id
//        currentGF.format = gameFormats[Int(game.gameFormat)].format
//                                   currentGF.description = gameFormats[Int(game.gameFormat)].description
//                                   currentGF.noOfPlayersNeeded = gameFormats[Int(game.gameFormat)].noOfPlayersNeeded
//                                   currentGF.playerHandAllowances = gameFormats[Int(game.gameFormat)].playerHandAllowances
//                                   currentGF.assignShotsRecd = gameFormats[Int(game.gameFormat)].assignShotsRecd
//                                   currentGF.assignTeamGrouping = gameFormats[Int(game.gameFormat)].assignTeamGrouping
//                                   currentGF.competitorSort = gameFormats[Int(game.gameFormat)].competitorSort
//                                   currentGF.playFormat = gameFormats[Int(game.gameFormat)].playFormat
//                                   currentGF.extraShotsTeamAdj = gameFormats[Int(game.gameFormat)].extraShotsTeamAdj
//                                   currentGF.bogey = gameFormats[Int(game.gameFormat)].bogey
//                                   currentGF.medal = gameFormats[Int(game.gameFormat)].medal
//                                   currentGF.stableford = gameFormats[Int(game.gameFormat)].stableford
//        
//    }
    
//    func updateGameFormat_GameDetail(gameFormat: GameFormatType, game: GameViewModel){
//        let manager = CoreDataManager.shared
//        let currentGame = manager.getGameById(id: game.id)
//        currentGame?.gameFormat = Int16(gameFormat.rawValue)
//        manager.save()
//    }
    
//    func updateHandicapFormat(game: GameViewModel) {
//        let manager = CoreDataManager.shared
//        let currentGame = manager.getGameById(id: game.id)
//        currentGame?.handicapFormat = gameDetail_HandicapFormat
//        currentGame?.scoreFormat = gameDetail_ScoreFormat
//        currentGame?.gameFormat = gameDetail_GameFormat
//        manager.save()
//    }
}

