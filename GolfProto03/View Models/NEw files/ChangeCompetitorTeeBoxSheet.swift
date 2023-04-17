//
//  ChangeCompetitorTeeBoxSheet.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct ChangeCompetitorTeeBoxSheet: View {
    let competitor: Competitor
    let game: GameViewModel
    var body: some View {
        VStack{
            Text(game.name)
            HStack{
                Text(competitor.FirstName())
                Text(competitor.LastName())
            }
        }
    }
}

struct ChangeCompetitorTeeBoxSheet_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        
        ChangeCompetitorTeeBoxSheet(competitor: competitor, game: game)
    }
}
