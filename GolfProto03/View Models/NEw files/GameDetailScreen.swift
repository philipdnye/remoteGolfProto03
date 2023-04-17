//
//  GameDetailScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.


import SwiftUI

struct GameDetailScreen: View {
    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var gameListVM = GameListViewModel()
    @State private var showingSheet: Bool = false
    @StateObject var addGameVM = AddGameViewModel()
    @Binding var needsRefresh: Bool
    @State private var refresh: Bool = false
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var currentGF: CurrentGameFormat
    @State private var isPresented: Bool = false
    //    @State var swipedCompetitor: CompetitorViewModel = CompetitorViewModel(competitor: Competitor())
    //    @State private var swipedCompetitor: Competitor = Competitor()
    
    private func deleteCompetitor(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let competitor = game.game.competitorArray[index]
            // delete the club
            gameListVM.deleteCompetitor(competitor: competitor)
            // get all clubs
            gameListVM.getAllCompetitors()
            
            
            
        }
    }
    
    private func FilterScoreFormats(pickedGameFormatID: Int) -> [ScoreFormat] {
        //        creates an array of ScoringFormats permitted by the picked GameFormat
        var filteredScoreFormats = ScoreFormat.allCases
        let pickedGameFormat = gameFormats.filter({$0.id == pickedGameFormatID})[0]
        if pickedGameFormat.medal == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.medal})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        if pickedGameFormat.stableford == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.stableford})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        if pickedGameFormat.bogey == false {
            let firstIndex = filteredScoreFormats.firstIndex(where: {$0 == ScoreFormat.bogey})
            filteredScoreFormats.remove(at: firstIndex ?? 0)
        }
        return filteredScoreFormats
    }
    
    private func onAdd() {
        
        isPresented.toggle()
    }
    
    let game: GameViewModel
    
    var body: some View {
        //        let currentGF = CurrentGameFormat()
        
        Form{
            Group{
                Text(game.name)
                //                Text(game.date.formatted(date: , time: ))
                
                
                //                Text(game.defaultTeeBox.wrappedColour)
                //                Text(game.defaultTeeBox.origin?.name ?? "")
                //                Text(game.defaultTeeBox.origin?.origin?.wrappedName ?? "")
                //                Text(game.game.game_format.stringValue())
                Text(game.game.sc_format.stringValue())
            }
            Group{
                Text(game.game.hcap_format.stringValue())
                Text(currentGF.description.description)
                
            }
            Group{
                //                Text("\(currentGF.id)")
                //                Text(refresh.description)
                Text(game.game.game_format.Succint_Description())
                Text(currentGF.playFormat.stringValue())
                
            }
            
            
            
            //            Section{
            //                let array = game.game.competitorArray
            //                ForEach(array, id: \.self){competitor in
            //                    NavigationLink(value:competitor, label:{
            //                        HStack{
            //                            Text(competitor.player?.firstName ?? "")
            //                            Text(competitor.player?.lastName ?? "")
            //                            Text(competitor.handicapIndex.formatted())
            //                            Text(competitor.courseHandicap.formatted())
            //                            Text(competitor.teeBox?.wrappedColour ?? "")
            //                            Text(competitor.player?.selectedForGame.description ?? "")
            //                        }
            //                    })
            
            //                    .swipeActions(edge:.leading, allowsFullSwipe: false) {
            //
            //                    Button {
            //
            ////                        let swipedCompetitor = competitor
            ////                let swipedCompetitor = competitor
            //                       // currentGF.swipedCompetitor = competitor
            //                        onAdd()
            //
            //
            //                } label: {
            //                    Text("Teebox")
            //            }
            //            .tint(.mint)
            //                                               }
            
            //                .navigationDestination(for: CompetitorViewModel.self){competitor in
            //                    ChangeCompetitorTeeBoxSheet(competitor: competitor, game: game)
            //                }
            
            
            
            
            
            
            .navigationBarBackButtonHidden(true)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        dismiss()
                        //code here to save the current game changes
                        print("Custom Action")
                        
                    } label: {
                        
                        HStack {
                            
                            Image(systemName: "chevron.backward")
                            Text("Games")
                        }
                    }
                }
                
            }
            
            //        .sheet(isPresented: $isPresented, onDismiss: {
            //            gameListVM.getAllGames()
            //        }, content: {
            //            ChangeCompetitorTeeBoxSheet(competitor: , game: game)
            //                .presentationDetents([.fraction(0.4)])
            //        })
            
            
            .onAppear(perform: {
                gameListVM.getAllGames()
                playerListVM.getAllPlayers()
                
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
                
            })
            
        }
    }
}
struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
            GameDetailScreen(needsRefresh: .constant(false),  game: game)
                .environmentObject(CurrentGameFormat())
        }
    }
}
