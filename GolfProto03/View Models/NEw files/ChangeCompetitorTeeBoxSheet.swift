//
//  ChangeCompetitorTeeBoxSheet.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct ChangeCompetitorTeeBoxSheet: View {
//    let competitor: CompetitorViewModel
    let game: GameViewModel
    var body: some View {
        Text(game.name)
        //Text(competitor.player.firstName ?? "")
    }
}

struct ChangeCompetitorTeeBoxSheet_Previews: PreviewProvider {
    static var previews: some View {
        //let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext))
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        ChangeCompetitorTeeBoxSheet(game: game)
    }
}
