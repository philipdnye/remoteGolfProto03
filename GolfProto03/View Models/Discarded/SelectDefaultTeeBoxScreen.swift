//
//  SelectDefaultTeeBoxScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import SwiftUI

struct SelectDefaultTeeBoxScreen: View {
    let game: GameViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SelectDefaultTeeBoxScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        SelectDefaultTeeBoxScreen(game: game)
    }
}
