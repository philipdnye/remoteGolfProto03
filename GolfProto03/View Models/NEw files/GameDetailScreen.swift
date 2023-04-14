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
    @StateObject var addGameVM = AddGameViewModel()
    @Binding var needsRefresh: Bool
    let game: GameViewModel
    
    var body: some View {
        Form{
            Text(game.name)
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
            ForEach(game.defaultCourse.teeBoxArray){teebox in
                Text(teebox.wrappedColour)
            }
            Picker("Select teebox", selection:$addGameVM.selectedTeeBox){
                Text("select teebox").tag(Optional<TeeBox>(nil))
                ForEach(game.defaultCourse.teeBoxArray, id: \.self){teeBox in
                    Text(teeBox.wrappedColour)
                        .tag(Optional(teeBox))
                }
            }
            
            
            
            
            
            
            
            
            Button("Save course to Game"){
                game.game.defaultCourse = addGameVM.selectedCourse
                CoreDataManager.shared.save()
            }
            Button("Save teeBox to Game"){
                game.game.defaultTeeBox = addGameVM.selectedTeeBox
                CoreDataManager.shared.save()
            }
        }
        .onAppear(perform: gameListVM.getAllGames)
    }
}

struct GameDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen(needsRefresh: .constant(false), game: game)
    }
}
