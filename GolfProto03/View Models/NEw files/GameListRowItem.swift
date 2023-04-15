//
//  GameListRowItem.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct GameListRowItem: View {
    @StateObject private var gameListVM = GameListViewModel()
    @Binding var needsRefresh: Bool
    let game: GameViewModel
    var body: some View {
        HStack{
            Text(game.name)
               
            Text(game.defaultTeeBox.wrappedColour)
            Text(game.defaultTeeBox.origin?.name ?? "")

            
        }
        .font(.caption2)
    }
}

struct GameListRowItem_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameListRowItem(needsRefresh: .constant(false), game: game)
    }
}
