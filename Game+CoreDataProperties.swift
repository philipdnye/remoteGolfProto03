//
//  Game+CoreDataProperties.swift
//  GolfProto03
//
//  Created by Philip Nye on 20/04/2023.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var date: Date?
    @NSManaged public var duration: Int16
    @NSManaged public var finished: Bool
    @NSManaged public var finishTime: Date?
    @NSManaged public var gameFormat: Int16
    @NSManaged public var handicapFormat: Int16
    @NSManaged public var name: String?
    @NSManaged public var playFormat: Int16
    @NSManaged public var scoreFormat: Int16
    @NSManaged public var started: Bool
    @NSManaged public var startingHole: Int16
    @NSManaged public var startTime: Date?
    @NSManaged public var teamAPlayingHandicap: Double
    @NSManaged public var teamAShotsReceived: Double
    @NSManaged public var teamBPlayingHandicap: Double
    @NSManaged public var teamBShotsReceived: Double
    @NSManaged public var teamCPlayingHandicap: Double
    @NSManaged public var teamCShotsReceived: Double
    @NSManaged public var teamADiffTeesXShots: Double
    @NSManaged public var teamBDiffTeesXShots: Double
    @NSManaged public var teamCDiffTeesXShots: Double
    @NSManaged public var competitors: NSSet?
    @NSManaged public var defaultTeeBox: TeeBox?
    
    public var competitorArray: [Competitor] {
            let set = competitors as? Set<Competitor> ?? []
            return set.sorted {
                $0.id < $1.id
            }
        }
}

// MARK: Generated accessors for competitors
extension Game {

    @objc(addCompetitorsObject:)
    @NSManaged public func addToCompetitors(_ value: Competitor)

    @objc(removeCompetitorsObject:)
    @NSManaged public func removeFromCompetitors(_ value: Competitor)

    @objc(addCompetitors:)
    @NSManaged public func addToCompetitors(_ values: NSSet)

    @objc(removeCompetitors:)
    @NSManaged public func removeFromCompetitors(_ values: NSSet)

}

extension Game : Identifiable {

}
