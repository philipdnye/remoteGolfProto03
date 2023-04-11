//
//  TeeBox+CoreDataProperties.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//
//

import Foundation
import CoreData
import UIKit


extension TeeBox {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeeBox> {
        return NSFetchRequest<TeeBox>(entityName: "TeeBox")
    }

    @NSManaged public var colour: String?
    @NSManaged public var courseRating: Double
    @NSManaged public var slopeRating: Int16
    @NSManaged public var teeBoxColor: UIColor?
    @NSManaged public var holes: NSSet?
    @NSManaged public var origin: Course?
    @NSManaged public var competitors: NSSet?
    
    public var holesArray: [Hole] {
        let set = holes as? Set<Hole> ?? []
        return set.sorted {
            $0.number < $1.number
        }
    }
    
    public var wrappedColour: String {
        colour ?? "Unknown colour"
    }

}

// MARK: Generated accessors for holes
extension TeeBox {

    @objc(addHolesObject:)
    @NSManaged public func addToHoles(_ value: Hole)

    @objc(removeHolesObject:)
    @NSManaged public func removeFromHoles(_ value: Hole)

    @objc(addHoles:)
    @NSManaged public func addToHoles(_ values: NSSet)

    @objc(removeHoles:)
    @NSManaged public func removeFromHoles(_ values: NSSet)

}

// MARK: Generated accessors for competitors
extension TeeBox {

    @objc(addCompetitorsObject:)
    @NSManaged public func addToCompetitors(_ value: Competitor)

    @objc(removeCompetitorsObject:)
    @NSManaged public func removeFromCompetitors(_ value: Competitor)

    @objc(addCompetitors:)
    @NSManaged public func addToCompetitors(_ values: NSSet)

    @objc(removeCompetitors:)
    @NSManaged public func removeFromCompetitors(_ values: NSSet)

}

extension TeeBox : Identifiable {

}
