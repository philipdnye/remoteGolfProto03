//
//  Course+CoreDataProperties.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Club?
    @NSManaged public var teeBoxes: NSSet?
//    @NSManaged public var games: NSSet?

    public var teeBoxArray: [TeeBox] {
        let set = teeBoxes as? Set<TeeBox> ?? []
        return set.sorted {
            $0.courseRating < $1.courseRating
        }
    }
    
}

// MARK: Generated accessors for teeBoxes
extension Course {

    @objc(addTeeBoxesObject:)
    @NSManaged public func addToTeeBoxes(_ value: TeeBox)

    @objc(removeTeeBoxesObject:)
    @NSManaged public func removeFromTeeBoxes(_ value: TeeBox)

    @objc(addTeeBoxes:)
    @NSManaged public func addToTeeBoxes(_ values: NSSet)

    @objc(removeTeeBoxes:)
    @NSManaged public func removeFromTeeBoxes(_ values: NSSet)

}

// MARK: Generated accessors for games
extension Course {

    @objc(addGamesObject:)
    @NSManaged public func addToGames(_ value: Game)

    @objc(removeGamesObject:)
    @NSManaged public func removeFromGames(_ value: Game)

    @objc(addGames:)
    @NSManaged public func addToGames(_ values: NSSet)

    @objc(removeGames:)
    @NSManaged public func removeFromGames(_ values: NSSet)

}

extension Course : Identifiable {

}
