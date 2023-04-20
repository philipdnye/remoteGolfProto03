//
//  Extensions_Competitor.swift
//  GolfProto03
//
//  Created by Philip Nye on 16/04/2023.
//

import Foundation


extension Competitor {
    func CourseHandicap() -> Double {
        let CH = (self.player?.handicapArray.currentHandicapIndex() ?? 0.0)*Double(self.teeBox?.slopeRating ?? 0)/113
        return CH
    }
}
extension Competitor {
    func FirstName() -> String {
        let FN = (self.player?.firstName ?? "")
        return FN
    }
}
extension Competitor {
    func LastName() -> String {
        let LN = (self.player?.lastName ?? "")
        return LN
    }
}
extension Competitor {
    func TeeBoxColour() -> String {
        let TBC = (self.teeBox?.wrappedColour ?? "")
        return TBC
    }
}

extension Competitor {
    func CourseRating() -> Double {
        let CR = self.teeBox?.courseRating ?? 70.0
        return CR
    }
}

extension Competitor {
    func SlopeRating() -> Int {
        let SR = Int(self.teeBox?.slopeRating ?? 122)
        return SR
    }
}
extension Competitor {
    var team_String: TeamAssignment {
        get{
            return TeamAssignment(rawValue: Int(self.team)) ?? .indiv
        } set {
            self.team = Int16(newValue.rawValue)
        }
    }
}

extension Competitor {
    func TotalPlayingHandicap () -> Double {
       let totalPH = Double(round(self.playingHandicap) + round(self.diffTeesXShots))
        return totalPH
    }
}
extension Competitor {
    func TotalPlayingHandicapUnrounded () -> Double {
       let totalPH = Double(self.playingHandicap + self.diffTeesXShots)
        return totalPH
    }
}

extension Competitor {
    func TotalShotsRecdMatch () -> Double {
        let totalSR = Double(self.shotsRecdMatch + self.diffTeesXShots)
        return totalSR
    }
}
