//
//  CoreDataManager.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    private init() {
        
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
        
        persistentContainer = NSPersistentCloudKitContainer(name: "GolfDataModel")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        
        
        persistentContainer.loadPersistentStores {(description, error) in
           
            
            
            
            
            if let error = error {
                fatalError("Failed to initialise Core Data \(error)")
            }
        }
        
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    func getClubById(id: NSManagedObjectID) -> Club? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Club
        } catch {
            print(error)
            return nil
        }
    }
    
    func getHandicapById(id: NSManagedObjectID) -> Handicap? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Handicap
        } catch {
            print(error)
            return nil
        }
    }
    
    func getPlayerById(id: NSManagedObjectID) -> Player? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Player
        } catch {
            print(error)
            return nil
        }
    }
    

    
    func getCourseById(id: NSManagedObjectID) -> Course? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Course
        } catch {
            print(error)
            return nil
        }
    }
    
    func getTeeBoxById(id: NSManagedObjectID) -> TeeBox? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? TeeBox
        } catch {
            print(error)
            return nil
        }
    }
    func getHoleById(id: NSManagedObjectID) -> Hole? {
        do {
            return try persistentContainer.viewContext.existingObject(with: id) as? Hole
        } catch {
            print(error)
            return nil
        }
    }
    
    
    func deleteClub(_ club: Club) {
        persistentContainer.viewContext.delete(club)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete club \(error)")
        }
    }
    
    func deleteHandicap(_ handicap: Handicap) {
        persistentContainer.viewContext.delete(handicap)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete handicap \(error)")
        }
    }
    
    func deletePlayer(_ player: Player) {
        persistentContainer.viewContext.delete(player)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete player \(error)")
        }
    }
    
    func deleteCourse(_ course: Course) {
        persistentContainer.viewContext.delete(course)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete course \(error)")
        }
    }
    
    func deleteTeeBox(_ teeBox: TeeBox) {
        persistentContainer.viewContext.delete(teeBox)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to delete teebox \(error)")
        }
    }
    
    func getAllClubs() -> [Club] {
        
        let fetchRequest: NSFetchRequest<Club> = Club.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
            print("Data saved to core data")
        } catch {
            print("Failed to save MOC \(error)")
        }
    }
    
    
    
}
