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
