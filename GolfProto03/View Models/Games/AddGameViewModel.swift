//
//  AddGameViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import SwiftUI


class AddGameViewModel: ObservableObject {
   
    var name: String = ""
    var date: Date = Date()
    
    @Published var selectedClub: ClubViewModel = ClubViewModel(club: Club())
    
//   @Published var club: Club = Club(context: CoreDataManager.shared.persistentContainer.viewContext)
    @StateObject private var clubListVM = ClubListViewModel()
    
    func save() {
        if name != "" {
            let manager = CoreDataManager.shared
            let game = Game(context: manager.persistentContainer.viewContext)
            
            game.name = name
            game.date = date
            game.club = selectedClub.club
            
            manager.save()
        }
    }
}
