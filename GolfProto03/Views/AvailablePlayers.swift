//
//  AvailablePlayers.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI

struct AvailablePlayers: View {
    @StateObject private var playerListVM = PlayerListViewModel()
    @StateObject private var gameListVM = GameListViewModel()
    
    
    var body: some View {
        ForEach(playerListVM.players, id: \.self){ player in
                            HStack{
                                Text(player.firstName)
                                Text(player.lastName)
                            }
        
//                            .swipeActions(allowsFullSwipe: true) {
//
//                                Button {
//                                   // let index = playerListVM.players.firstIndex(where: {$0 == player}) ?? 0
////                                    print(index)
////
////                                    let manager = CoreDataManager.shared
////                                    let competitor = Competitor(context: manager.persistentContainer.viewContext)
////                                    competitor.game = game.game
////                                    competitor.player = playerListVM.players[index].player
////                                    competitor.teeBox = game.defaultTeeBox
////                                    manager.save()
////                                    refresh.toggle()
//
//                                } label: {
//                                    Label("Mute", systemImage: "person.fill.badge.plus")
//                                }
//                                .tint(.indigo)
//
//
//                            }
//
                        }
        
        .onAppear(perform: {
            //gameListVM.getAllGames()
            playerListVM.getAllPlayers()
        })
    }
}

struct AvailablePlayers_Previews: PreviewProvider {
    static var previews: some View {
        //let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        AvailablePlayers()
    }
}
