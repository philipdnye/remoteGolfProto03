//
//  GameDetailScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

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
                Text(game.club.wrappedName)
                Text(game.defaultCourse.name ?? "unknown course")
                Text(game.defaultTeeBox.wrappedColour)
                
                
                Picker("Select course", selection: $addGameVM.selectedCourse){
                    Text("Select course").tag(Optional<Course>(nil))
                    
                    ForEach(game.club.courseArray, id: \.self){course in
                        Text(course.name ?? "")
                            .tag(Optional(course))
                    }
                    
                    //                as? Set<Hole> ?? []
                    
                    //                Text(addGameVM.selectedCourse.name ?? "unknown course")
                }
//                .onReceive([self.addGameVM.selectedCourse].publisher.first()){course in
//                    game.game.defaultCourse = addGameVM.selectedCourse
//                    CoreDataManager.shared.save()
////                    game.defaultCourse
//                }
                Button("Save course to Game"){
                    game.game.defaultCourse = addGameVM.selectedCourse
                    CoreDataManager.shared.save()
                    refresh.toggle()
                }
                
                Picker("Select teebox", selection:$addGameVM.selectedTeeBox){
                    Text("select teebox").tag(Optional<TeeBox>(nil))
                    ForEach(game.defaultCourse.teeBoxArray, id: \.self){teeBox in
                        Text(teeBox.wrappedColour)
                            .tag(Optional(teeBox))
                    }
                }
            
            
            
            Button("Save teeBox to Game"){
                game.game.defaultTeeBox = addGameVM.selectedTeeBox
                CoreDataManager.shared.save()
                refresh.toggle()
            }
        }
            
            Section{
                ForEach(game.game.competitorArray){competitor in
                                   HStack{
                                       Text(competitor.player?.firstName ?? "")
                                       Text(competitor.player?.lastName ?? "")
                                   }
                    
                                   
//                                   .swipeActions(allowsFullSwipe: true){
//                                       Button{
//                                           let index = game.game.competitorArray.firstIndex(where: {$0 == competitor}) ?? 0
//                                           let manager = CoreDataManager.shared
//
//                                       } label: {
//                                           Label("Mute", systemImage: "person.fill.badge.minus")
//                                       }
//                                       .tint(.red)
//                                   }
                               }
                .onDelete(perform: deleteCompetitor)

            }
           
            
            
            Section {
                ForEach(playerListVM.players, id: \.id){ player in
                    HStack{
                        Text(player.firstName)
                        Text(player.lastName)
                    }
                    
                    .swipeActions(allowsFullSwipe: true) {
                        
                        Button {
                            let index = playerListVM.players.firstIndex(where: {$0 == player}) ?? 0
                            print(index)
                            
                            let manager = CoreDataManager.shared
                            let competitor = Competitor(context: manager.persistentContainer.viewContext)
                            competitor.game = game.game
                            competitor.player = playerListVM.players[index].player
                            manager.save()
                            refresh.toggle()
//                            players.allPlayers[index].selectedForGame = true
                            //                        resetGameFormatPicker()
                        } label: {
                            Label("Mute", systemImage: "person.fill.badge.plus")
                        }
                        .tint(.indigo)
                        //.disabled(players.allPlayers.UnDeleted().filter({$0.selectedForGame == true}).count == 4)
                        
                    }
                    
                }
                Text(refresh.description)
            }
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
