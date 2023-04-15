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
    @Published var competitors = [CompetitorViewModel]()
    
    private var fetchedResultsController: NSFetchedResultsController<Game>!
    private var fetchedResultsControllerCompetitor: NSFetchedResultsController<Competitor>!
    func deleteGame(game: GameViewModel){
        let game = CoreDataManager.shared.getGameById(id: game.id)
        if let game = game {
            CoreDataManager.shared.deleteGame(game)
        }
    }
    
    func deleteCompetitor(competitor: Competitor) {
        let competitor = CoreDataManager.shared.getCompetitorById(id: competitor.objectID)
        if let competitor = competitor {
            CoreDataManager.shared.deleteCompetitor(competitor)
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
    
    func getAllCompetitors () {
        let request: NSFetchRequest<Competitor> = Competitor.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "handicapIndex", ascending: false)]
        fetchedResultsControllerCompetitor = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsControllerCompetitor.delegate = self
        try? fetchedResultsControllerCompetitor.performFetch()
        DispatchQueue.main.async {
            self.competitors = (self.fetchedResultsControllerCompetitor.fetchedObjects ??
            
                          []).map(CompetitorViewModel.init)
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
    
//    var club: Club {
//        return game.club ?? Club(context: CoreDataManager.shared.persistentContainer.viewContext)
//        
//    }
    
    var defaultTeeBox: TeeBox {
        return game.defaultTeeBox ?? TeeBox(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    
//    var defaultCourse: Course {
//        return game.defaultCourse ?? Course(context: CoreDataManager.shared.persistentContainer.viewContext)
//    }
    
    var length: Int16 {
        return game.length
    }
    
    var gameFormat: Int16 {
        return game.gameFormat
    }
    
    var playFormat: Int16 {
        return game.playFormat
    }
    
    var scoreFormat: Int16 {
        return game.scoreFormat
    }
}


struct CompetitorViewModel: Hashable {
    let competitor: Competitor
   
    var id: NSManagedObjectID {
        return competitor.objectID
    }
    var handicapIndex: Double {
        return competitor.handicapIndex
    }
    var playingHandicap: Double {
        return competitor.playingHandicap
    }
    var courseHandicap: Double {
        return competitor.courseHandicap
    }
    var player: Player {
        return competitor.player ?? Player(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    var teeBox: TeeBox {
        return competitor.teeBox ?? TeeBox(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
    var game: Game {
        return competitor.game ?? Game(context: CoreDataManager.shared.persistentContainer.viewContext)
    }
}
