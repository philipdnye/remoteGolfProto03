//
//  GameDetailScreen2.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct GameDetailScreen2: View {
    
    @StateObject private var gameListVM = GameListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    
    @State private var isPresented: Bool = false
    var GameSummary: some View {
        VStack{
            Text(game.name)
            Text(game.defaultTeeBoxColour)
            Text(game.clubName)
            Text(game.courseName)
            Text(game.handicapFormatName)
            Text(game.scoreFormatName)
            Text(game.succinctDescription)
            
            Text(currentGF.description.description)
            Text(currentGF.playFormat.stringValue())
            
        }
    }
    func OnAppear() {
        gameListVM.getAllGames()
//            playerListVM.getAllPlayers()
        
        currentGF.id = gameFormats[Int(game.gameFormat)].id
        currentGF.format = gameFormats[Int(game.gameFormat)].format
        currentGF.description = gameFormats[Int(game.gameFormat)].description
        currentGF.noOfPlayersNeeded = gameFormats[Int(game.gameFormat)].noOfPlayersNeeded
        currentGF.playerHandAllowances = gameFormats[Int(game.gameFormat)].playerHandAllowances
        currentGF.assignShotsRecd = gameFormats[Int(game.gameFormat)].assignShotsRecd
        currentGF.assignTeamGrouping = gameFormats[Int(game.gameFormat)].assignTeamGrouping
        currentGF.competitorSort = gameFormats[Int(game.gameFormat)].competitorSort
        currentGF.playFormat = gameFormats[Int(game.gameFormat)].playFormat
        currentGF.extraShotsTeamAdj = gameFormats[Int(game.gameFormat)].extraShotsTeamAdj
        currentGF.bogey = gameFormats[Int(game.gameFormat)].bogey
        currentGF.medal = gameFormats[Int(game.gameFormat)].medal
        currentGF.stableford = gameFormats[Int(game.gameFormat)].stableford
    }
    private func onAdd() {
        
        isPresented.toggle()
    }
    let game: GameViewModel
    
    var body: some View {
        VStack{
            GameSummary
            Form{
                ForEach(Array(game.game.competitorArray), id: \.self){competitor in
                    HStack{
                        Text(competitor.FirstName())
                        Text(competitor.LastName())
                        Text(competitor.TeeBoxColour())
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false){
                        Button{
                            currentGF.swipedCompetitor = competitor
                            onAdd()
                        } label: {
                            Text("TeeBox")
                        }
                        .tint(.mint)
                    }
                }
            }
        }
        
                .sheet(isPresented: $isPresented, onDismiss: {
                    gameListVM.getAllGames()
                    
                }, content: {
                    ChangeCompetitorTeeBoxSheet(competitor: currentGF.swipedCompetitor, game: game)
                        .presentationDetents([.fraction(0.4)])
                })
        
        
        .onAppear(perform: {
           OnAppear()
        })
    }
}

struct GameDetailScreen2_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen2(game:game)
            .environmentObject(CurrentGameFormat())
    }
}
