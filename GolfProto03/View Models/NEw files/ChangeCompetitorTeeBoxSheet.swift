//
//  ChangeCompetitorTeeBoxSheet.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct ChangeCompetitorTeeBoxSheet: View {
    @StateObject private var addGameVM = AddGameViewModel()
    let competitor: Competitor
    let game: GameViewModel
    @Binding var isPresented: Bool
    @Binding var neeedsRefresh: Bool
    //@State private var newTeeBox: TeeBox = TeeBox()
    var body: some View {
        Form{
            Text(game.name)
            HStack{
                Text(competitor.FirstName())
                Text(competitor.LastName())
            }
            Text(game.clubName)
            Text(game.courseName)
            
            Picker("Select teebox", selection: $addGameVM.newTeeBox) {
                ForEach(game.game.defaultTeeBox?.origin?.teeBoxArray ?? [], id: \.self){
                    Text($0.wrappedColour)
                        .tag($0)
                }
            }
            HStack{
                Spacer()
                Button("Save new teebox"){
                    let manager = CoreDataManager.shared
//                    let currentGame = manager.getGameById(id: game.id)
                    let competitorId = competitor.objectID
                    let currentCompetitor = manager.getCompetitorById(id: competitorId)
                    currentCompetitor?.teeBox = addGameVM.newTeeBox
                    //code here to update course handicap
                    currentCompetitor?.courseHandicap = competitor.CourseHandicap()
                    manager.save()
                    isPresented = false
                    neeedsRefresh.toggle()
                }
                Spacer()
            }

        }
        .onAppear(perform:{
            addGameVM.newTeeBox = competitor.teeBox ?? TeeBox()
        })
    }
}

struct ChangeCompetitorTeeBoxSheet_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        
        ChangeCompetitorTeeBoxSheet(competitor: competitor, game: game, isPresented: .constant(true), neeedsRefresh: .constant(false))
    }
}
