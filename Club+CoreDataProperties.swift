//
//  Club+CoreDataProperties.swift
//  GolfProto03
//
//  Created by Philip Nye on 13/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension Club {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Club> {
        return NSFetchRequest<Club>(entityName: "Club")
    }

    @NSManaged public var addressLine1: String?
    @NSManaged public var addressLine2: String?
    @NSManaged public var addressLine3: String?
    @NSManaged public var addressLine4: String?
    @NSManaged public var clubImage: UIImage?
    @NSManaged public var distMetric: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var postCode: String?
    @NSManaged public var course22: NSSet?
    @NSManaged public var games: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown name"
    }
    public var wrappedAddressLine1: String {
        addressLine1 ?? "Unkown address line 1"
    }
    
    public var wrappedAddressLine2: String {
        addressLine2 ?? "Unkown address line 2"
    }
    
    public var wrappedAddressLine3: String {
        addressLine3 ?? "Unkown address line 3"
    }
    
    public var wrappedAddressLine4: String {
        addressLine4 ?? "Unkown address line 4"
    }
    
    public var wrappedPostCode: String {
        postCode ?? "Unkown post code"
    }
    
    public var wrappedDistMetric: String {
        distMetric ?? "Unkown dist metric"
    }
    public var wrappedEmail: String {
        email ?? "Unkown email"
    }
    
    public var courseArray: [Course] {
        let set = course22 as? Set<Course> ?? []
        return set.sorted {
            $0.name ?? "" < $1.name ??  ""
        }
    }
    public var gameArray: [Game] {
        let set = games as? Set<Game> ?? []
        return set.sorted {
            $0.date ?? Date() < $1.date ??  Date()
        }
    }
}

// MARK: Generated accessors for course22
extension Club {

    @objc(addCourse22Object:)
    @NSManaged public func addToCourse22(_ value: Course)

    @objc(removeCourse22Object:)
    @NSManaged public func removeFromCourse22(_ value: Course)

    @objc(addCourse22:)
    @NSManaged public func addToCourse22(_ values: NSSet)

    @objc(removeCourse22:)
    @NSManaged public func removeFromCourse22(_ values: NSSet)

}

// MARK: Generated accessors for game
extension Club {

    @objc(addGameObject:)
    @NSManaged public func addToGame(_ value: Game)

    @objc(removeGameObject:)
    @NSManaged public func removeFromGame(_ value: Game)

    @objc(addGame:)
    @NSManaged public func addToGame(_ values: NSSet)

    @objc(removeGame:)
    @NSManaged public func removeFromGame(_ values: NSSet)

}

extension Club : Identifiable {

}
