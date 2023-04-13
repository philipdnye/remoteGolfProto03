//
//  GameListViewModel.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import Foundation
import CoreData
import SwiftUI

class GameListViewModel: NSObject, ObservableObject {
    
    @Published var games = [GameViewModel]()
    
    private var fetchedResultsController: NSFetchedResultsController<Game>!
   
    func deleteGame(game: GameViewModel){
        let game = CoreDataManager.shared.getGameById(id: game.id)
        if let game = game {
            CoreDataManager.shared.deleteGame(game)
        }
    }
    
    func getAllGames () {
        let request: NSFetchRequest<Game> = Game.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        DispatchQueue.main.async {
            self.games = (self.fetchedResultsController.fetchedObjects ??
            
                          []).map(GameViewModel.init)
        }
    }
    
}


extension GameListViewModel: NSFetchedResultsControllerDelegate {
    
}


struct GameViewModel: Hashable {
    
    let game: Game
    
    var id: NSManagedObjectID {
        return game.objectID
    }
    
    var name: String {
        return game.name ?? ""
    }
    
    var date: Date {
        return game.date ?? Date()
    }
    
    var club: Club {
        return game.club ?? Club(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
}
