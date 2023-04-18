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
    @State private var isPresentedHcap: Bool = false
    @State private var needsRefresh: Bool = false
    
//    var GameSummary: some View {
//        VStack(alignment: .leading, spacing: 0){
//            GameSummaryForDetailScreen(game: game)
//            Group{
//                Text(game.name)
//                Text(game.defaultTeeBoxColour)
//                Text(game.clubName)
//                Text(game.courseName)
//                Text(game.handicapFormatName)
//                Text(game.scoreFormatName)
//                Text(game.succinctDescription)
//            }
//            Group {
//                Text(currentGF.description.description)
//                Text(currentGF.playFormat.stringValue())
//                Text(game.durationName)
//                Text(game.startingHole.formatted())
//                Text(game.startingHoleString)
//            }
//        }
//    }
    func OnAppear() {
        gameListVM.getAllGames()

        gameListVM.updateCurrentGameFormat(currentGF: currentGF, game: game.game)

    }
    private func onAdd() {
        
        isPresented.toggle()
    }
    
    private func onAddHcap() {
        
        isPresentedHcap.toggle()
    }
    let game: GameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
//            Text(needsRefresh.description)
            GameSummaryForDetailScreen(game: game)
            Form{
                Section {
                ForEach(Array(game.game.competitorArray), id: \.self){competitor in
                    CompetitorRowItem_GameDetail(competitor: competitor, needsRefresh: $needsRefresh)
                        .swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button{
                                currentGF.swipedCompetitor = competitor
                                onAdd()
                            } label: {
                                Text("TeeBox")
                            }
                            .tint(.mint)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false){
                            Button{
                                currentGF.swipedCompetitor = competitor
                               onAddHcap()
                            } label: {
                                Label("Handicap calculation",systemImage: "h.circle")
                            }
                            .tint(darkTeal)
                        }
                    
                }
            } //section
            header: {
                         
                         Text("Players in this game")
                     } footer: {
                         
                         Text("Swipe right to change the players teebox")
                     }
            }
           
        }
        
                .sheet(isPresented: $isPresented, onDismiss: {
                    gameListVM.getAllGames()
                    
                }, content: {
                    ChangeCompetitorTeeBoxSheet(competitor: currentGF.swipedCompetitor, game: game, isPresented: $isPresented, neeedsRefresh: $needsRefresh)
                        .presentationDetents([.fraction(0.25)])
                })
        
                .sheet(isPresented: $isPresentedHcap, onDismiss: {
                    
                }, content: {
                    CourseHandicapCalcScreen(isPresentedHcap: $isPresentedHcap, competitor: currentGF.swipedCompetitor)
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
