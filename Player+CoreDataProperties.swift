//
//  Player+CoreDataProperties.swift
//  GolfProto03
//
//  Created by Philip Nye on 25/03/2023.
//
//

import Foundation
import CoreData
import UIKit

extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var gender: String?
    @NSManaged public var lastName: String?
    @NSManaged public var mobile: String?
    @NSManaged public var photo: UIImage?
    @NSManaged public var handicap: NSSet?
    
    public var handicapArray: [Handicap] {
        let set = handicap as? Set<Handicap> ?? []
        return set.sorted {
            $0.startDate ?? Date() > $1.startDate ?? Date()
        }
    }

}

// MARK: Generated accessors for handicap
extension Player {

    @objc(addHandicapObject:)
    @NSManaged public func addToHandicap(_ value: Handicap)

    @objc(removeHandicapObject:)
    @NSManaged public func removeFromHandicap(_ value: Handicap)

    @objc(addHandicap:)
    @NSManaged public func addToHandicap(_ values: NSSet)

    @objc(removeHandicap:)
    @NSManaged public func removeFromHandicap(_ values: NSSet)

}

extension Player : Identifiable {

}
