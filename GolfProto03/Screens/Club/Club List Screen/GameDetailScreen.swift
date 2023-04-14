//
//  GameDetailScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct GameDetailScreen: View {
    @StateObject private var gameListVM = GameListViewModel()
    @State private var showingSheet: Bool = false
    @Binding var needsRefresh: Bool
    let game: GameViewModel
    
    var body: some View {
        VStack{
            Text(game.name)
            Text(game.club.wrappedName)
            Text(game.defaultTeeBox.wrappedColour)
        }
    }
}

struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen(needsRefresh: .constant(false), game: game)
    }
}
