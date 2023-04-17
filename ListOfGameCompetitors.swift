//
//  ListOfGameCompetitors.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct ListOfGameCompetitors: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    @State private var showingSheet: Bool = false
    var game: GameViewModel
    
    var body: some View {
        ForEach(game.game.competitorArray, id: \.self){competitor in
            HStack{
                Text(competitor.player?.firstName ?? "")
                Text(competitor.player?.lastName ?? "")
                Text(competitor.handicapIndex.formatted())
                Text(competitor.courseHandicap.formatted())
                Text(competitor.teeBox?.wrappedColour ?? "")
                Text(competitor.player?.selectedForGame.description ?? "")
            }
            .swipeActions(edge:.leading, allowsFullSwipe: false) {
            
            Button {
               // currentGF.swipedCompetitor = competitor
                showingSheet.toggle()
                
              
        } label: {
            Text("Teebox")
    }
    .tint(.mint)
            
            
                                        }
        }
        
    }
}

struct ListOfGameCompetitors_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        ListOfGameCompetitors(game: game)
    }
}
