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
    
    private func deleteCompetitor(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let competitor = game.game.competitorArray[index]
            // delete the club
            gameListVM.deleteCompetitor(competitor: competitor)
            // get all clubs
            gameListVM.getAllCompetitors()
            
            
         
        }
    }
    
    let game: GameViewModel
    
    var body: some View {
        Form{
            Section{
                Text(game.game.name ?? "")
                Text(game.date.formatted())
                
                   
                Text(game.defaultTeeBox.wrappedColour)
                Text(game.defaultTeeBox.origin?.name ?? "")
                Text(game.defaultTeeBox.origin?.origin?.wrappedName ?? "")
                Picker("Game", selection: $addGameVM.pickerGameFormat){
                    ForEach(GameFormatType.allCases.sorted(by: {
                        $0.rawValue > $1.rawValue
                    }), id: \.self) {gameFormat in
                        Text(gameFormat.stringValue())
                            .tag(gameFormat)
                    }
                }
                .onAppear(perform: {
                    addGameVM.pickerGameFormat = game.game.game_format
                })
                
//                Text(game.club.wrappedName)
//                Text(game.defaultCourse.name ?? "unknown course")
//                Text(game.defaultTeeBox.wrappedColour)
                
//
//                Picker("Select course", selection: $addGameVM.selectedCourse){
//                    Text("Select course").tag(Optional<Course>(nil))
//
//                    ForEach(game.club.courseArray, id: \.self){course in
//                        Text(course.name ?? "")
//                            .tag(Optional(course))
//                    }
//
//                }
//
//                Button("Save course to Game"){
//                    game.game.defaultCourse = addGameVM.selectedCourse
//                    CoreDataManager.shared.save()
//                    refresh.toggle()
//                }
//
//                Picker("Select teebox", selection:$addGameVM.selectedTeeBox){
//                    Text("select teebox").tag(Optional<TeeBox>(nil))
//                    ForEach(game.defaultCourse.teeBoxArray, id: \.self){teeBox in
//                        Text(teeBox.wrappedColour)
//                            .tag(Optional(teeBox))
//                    }
//                }
//
//
//
//            Button("Save teeBox to Game"){
//                game.game.defaultTeeBox = addGameVM.selectedTeeBox
//                CoreDataManager.shared.save()
//                refresh.toggle()
//            }
        }
            
//            Section{
//                ForEach(game.game.competitorArray){competitor in
//                                   HStack{
//                                       Text(competitor.player?.firstName ?? "")
//                                       Text(competitor.player?.lastName ?? "")
//                                       Text(competitor.player?.handicapArray.currentHandicapIndex().formatted() ?? "0.0")
//                                       Text(competitor.teeBox?.wrappedColour ?? "")
//                                   }
//
//
////                                   .swipeActions(allowsFullSwipe: true){
////                                       Button{
////                                           let index = game.game.competitorArray.firstIndex(where: {$0 == competitor}) ?? 0
////                                           let manager = CoreDataManager.shared
////
////                                       } label: {
////                                           Label("Mute", systemImage: "person.fill.badge.minus")
////                                       }
////                                       .tint(.red)
////                                   }
//                               }
//                .onDelete(perform: deleteCompetitor)
//
//            }
//
            
            
//            Section {
//                ForEach(playerListVM.players, id: \.id){ player in
//                    HStack{
//                        Text(player.firstName)
//                        Text(player.lastName)
//                    }
//
//                    .swipeActions(allowsFullSwipe: true) {
//
//                        Button {
//                            let index = playerListVM.players.firstIndex(where: {$0 == player}) ?? 0
//                            print(index)
//
//                            let manager = CoreDataManager.shared
//                            let competitor = Competitor(context: manager.persistentContainer.viewContext)
//                            competitor.game = game.game
//                            competitor.player = playerListVM.players[index].player
//                            competitor.teeBox = game.defaultTeeBox
//                            manager.save()
//                            refresh.toggle()
//
//                        } label: {
//                            Label("Mute", systemImage: "person.fill.badge.plus")
//                        }
//                        .tint(.indigo)
//
//
//                    }
//
//                }
////                Text(refresh.description)
////                Text(game.game.competitors?.count.formatted() ?? "0")
//            }
//            Section{
//                Picker("Score format", selection:$addGameVM.pickerScoringFormat){
//                    ForEach(ScoreFormat.allCases, id: \.self){format in
//
//                        Text(format.stringValue())
//                            .tag(format)
//                    }
//                }
//                Picker("Handicap",selection: $addGameVM.pickerHandicapFormat){
//                    ForEach(HandicapFormat.allCases, id: \.self){format in
//                        Text(format.stringValue())
//                            .tag(format)
//
//                    }
//                }
//                Picker("Play format",selection: $addGameVM.pickerPlayFormat){
//                    ForEach(PlayFormat.allCases, id: \.self){format in
//                        Text(format.stringValue())
//                            .tag(format)
//
//                    }
//                }
//                Picker("Game format", selection: $addGameVM.pickerGameFormat){
//                    ForEach(GameFormatType.allCases.sorted(by: {
//                        $0.rawValue > $1.rawValue
//                    }), id: \.self) {gameFormat in
//                        Text(gameFormat.stringValue())
//                            .tag(gameFormat)
//                    }
//                }
//
//            }
        }
        .onAppear(perform: {
            gameListVM.getAllGames()
            playerListVM.getAllPlayers()
        })
    }
}

struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen(needsRefresh: .constant(false), game: game)
    }
}
