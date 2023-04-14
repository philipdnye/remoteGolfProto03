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

    @Published var selectedClub: ClubViewModel = ClubViewModel(club: Club())
    @Published var selectedCourse: CourseViewModel = CourseViewModel(course: Course())
    @Published var selectedTeeBox: TeeBoxViewModel = TeeBoxViewModel(teeBox: TeeBox())
    

    
    func save() {
        if name != "" {
            let manager = CoreDataManager.shared
            let game = Game(context: manager.persistentContainer.viewContext)
            
            game.name = name
            game.date = date
            game.club = selectedClub.club
            
//            game.defaultTeeBox = selectedTeeBox.teeBox
//            game.club = game.defaultTeeBox?.origin?.origin
            manager.save()
        }
        
        
    }
}


