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
    
    func save() {
        let manager = CoreDataManager.shared
        let game = Game(context: manager.persistentContainer.viewContext)
        
        game.name = name
        game.date = date
        
        manager.save()
        
    }
}
