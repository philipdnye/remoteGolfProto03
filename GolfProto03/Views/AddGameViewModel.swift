//
//  AddGameViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import SwiftUI


class AddGameViewModel: ObservableObject {
    @StateObject private var clubListVM = ClubListViewModel()
    var name: String = ""
    var date: Date = Date()
    var teeBox: TeeBox = TeeBox()
//    var gameFormat: Int16 = 0

    
    @Published var pickedClub: Int = 0
    @Published var pickedCourse: Int = 0
    @Published var pickedTeeBox: Int = 0
    
    
    
    @Published var selectedClub: ClubViewModel = ClubViewModel(club: Club())
    @Published var selectedCourse: Course = Course()
    @Published var selectedTeeBox: TeeBox = TeeBox()
    
    @Published var pickerScoringFormat: ScoreFormat = .medal
    @Published var pickerHandicapFormat: HandicapFormat = .handicap
    @Published var pickerPlayFormat: PlayFormat = .strokeplay
    @Published var pickerGameFormat: GameFormatType = .fourBallBBMatch

    
    func save() {
      
            let manager = CoreDataManager.shared
            let game = Game(context: manager.persistentContainer.viewContext)
            
            game.name = name
            game.date = date
            game.defaultTeeBox = teeBox
            game.gameFormat = Int16(pickerGameFormat.rawValue)
            
            manager.save()
       
    }
}


