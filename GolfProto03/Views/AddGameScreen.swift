//
//  TestViewClubArray.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI





struct AddGameScreen: View {
    @StateObject private var gameListVM = GameListViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var playerListVM = PlayerListViewModel()
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var currentGF: CurrentGameFormat
    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
 
    
//    func AssignCompetitorTeams(game: Game) {
//        switch currentGF.assignTeamGrouping {
//        case .Indiv:
//            for i in 0..<(game.competitorArray.count) {
//                game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
//            }
//        case .TeamsAB:
//            switch currentGF.noOfPlayersNeeded {
//            case 4:
//                for i in 0..<(game.competitorArray.count) {
//                    switch i {
//                    case 0:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
//                    case 1:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
//                    case 2:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
//                    case 3:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
//                    default:
//                        game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
//                    }
//                }
//            case 2:
//                for i in 0..<(game.competitorArray.count)    {
//                    switch i {
//                    case 0:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamA.rawValue)
//                    case 1:
//                        game.competitorArray[i].team = Int16(TeamAssignment.teamB.rawValue)
//                    default:
//                        game.competitorArray[i].team = Int16(TeamAssignment.indiv.rawValue)
//                    }
//                }
//            default:
//                game.competitorArray[0].team = Int16(TeamAssignment.indiv.rawValue)
//            }
//        case .TeamC:
//            for i in 0..<(game.competitorArray.count) {
//                game.competitorArray[i].team = Int16(TeamAssignment.teamC.rawValue)
//            }
//        }
//    }
//    func AssignPlayingHandicaps (game: Game) {
//        switch currentGF.competitorSort {
//        case .TeamsAB:
//
//            func TeamABLowHigh (competitors: [Competitor]) -> (teamALow:Competitor, teamAHigh: Competitor, teamBLow: Competitor, teamBHigh: Competitor){
//                let teamA = competitors.filter({$0.team == TeamAssignment.teamA.rawValue})
//                let teamB = competitors.filter({$0.team == TeamAssignment.teamB.rawValue})
//                let teamAHigh = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.max()})
//                let teamBHigh = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.max()})
//                let teamALow = teamA.filter({$0.courseHandicap == teamA.map{$0.courseHandicap}.min()})
//                let teamBLow = teamB.filter({$0.courseHandicap == teamB.map{$0.courseHandicap}.min()})
//
//                return (teamALow[0], teamAHigh[0], teamBLow[0], teamBHigh[0])
//            }
//
//
//            switch currentGF.noOfPlayersNeeded{
//            case 4:
//                let teamALowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamALow.id})
//                let teamAHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamAHigh.id})
//                let teamBLowIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBLow.id})
//                let teamBHighIndex = game.competitorArray.firstIndex(where: {$0.id == TeamABLowHigh(competitors: game.competitorArray).teamBHigh.id})
//
//                game.competitorArray[teamALowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[0]
//                game.competitorArray[teamAHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[1]
//                game.competitorArray[teamBLowIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[2]
//                game.competitorArray[teamBHighIndex ?? 0].handicapAllowance = currentGF.playerHandAllowances[3]
//
//
//            case 2:
//                for i in 0..<game.competitorArray.count {
//                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
//                }
//            default:
//                for i in 0..<game.competitorArray.count {
//                    game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
//                }
//            }
//        case .Indiv:
//            for i in 0..<game.competitorArray.count {
//                game.competitorArray[i].handicapAllowance = currentGF.playerHandAllowances[i]
//            }
//
//        case .TeamC:
//            let sortedCompetitors = game.competitorArray.sorted(by: {$0.handicapIndex < $1.handicapIndex})
//
//            for i in 0..<sortedCompetitors.count {
//                sortedCompetitors[i].handicapAllowance = currentGF.playerHandAllowances[i]
//            }
//        }
//        // NOW ASSIGN THE PLAYING HANDICAP
//        for i in 0..<game.competitorArray.count {
//            game.competitorArray[i].playingHandicap = game.competitorArray[i].courseHandicap * game.competitorArray[i].handicapAllowance
//        }
//    }
    
   private func createGame () {

       let manager = CoreDataManager.shared
       let game = Game(context: manager.persistentContainer.viewContext)
       
       game.name = addGameVM.name
       game.date = addGameVM.date
       game.defaultTeeBox = clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: addGameVM.pickedTeeBox) ?? TeeBox()
       game.gameFormat = Int16(addGameVM.pickerGameFormat.rawValue)
       game.duration = Int16(addGameVM.pickerGameDuration)
       game.startingHole = Int16(addGameVM.pickerStartingHole)
       
           for player in playerListVM.players.filter({$0.selectedForGame == true}) {
               let competitor = Competitor(context: manager.persistentContainer.viewContext)
               competitor.player = player.player
               competitor.game = game
               competitor.teeBox = game.defaultTeeBox
               competitor.handicapIndex = player.player.handicapArray.currentHandicapIndex()
               competitor.courseHandicap = competitor.CourseHandicap()
               player.player.selectedForGame.toggle()
           }
      
       game.scoreFormat = Int16(addGameVM.pickerScoringFormat.rawValue)
       game.handicapFormat = Int16(addGameVM.pickerHandicapFormat.rawValue)
      
       manager.save()

       gameListVM.updateCurrentGameFormat(currentGF: currentGF, game: game)
       
       
       //code here to assign competitor teams
       
       addGameVM.AssignCompetitorTeams(game: game, currentGF: currentGF)
       addGameVM.AssignPlayingHandicaps (game: game, currentGF: currentGF)
       addGameVM.AssignTeamPlayingHandicap(game: game, currentGF: currentGF)
       addGameVM.AssignShotsReceived(game: game, currentGF: currentGF)
       manager.save()
       presentationMode.wrappedValue.dismiss()
       
    }
    

    
    private func togglePlayerSelected (player: PlayerViewModel) {
        let manager = CoreDataManager.shared
        let selectedPlayer = manager.getPlayerById(id: player.id)
        selectedPlayer?.selectedForGame.toggle()
       
        manager.save()
        playerListVM.getAllPlayers()
        
        // need code here to not only determine default format for selected no of players,
        // but also forces a value into the picker
        
        switch playerListVM.players.filter({$0.selectedForGame == true}).count {
        case 1:
            addGameVM.pickerGameFormat = .noneOnePlayer
        case 2:
            addGameVM.pickerGameFormat = .singlesMatchplay
        case 3:
            addGameVM.pickerGameFormat = .sixPoint
        case 4:
            addGameVM.pickerGameFormat = .fourBallBBMatch
        default:
            addGameVM.pickerGameFormat = .noFormat
        }
        
        //need a function to calculate the players course handicap
    }
    
    var body: some View {
      
//        let currentGF = CurrentGameFormat()
       
       
        Form{
            Section{
                TextField("Enter name for this game",text: $addGameVM.name)

                    .keyboardType(.default)
                    .focused($AddGameViewInFocus, equals: .name)

                DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
                    Text("Game played on: ")


                }
                .focused($AddGameViewInFocus, equals: .date)

                Picker("Select club", selection: $addGameVM.pickedClub) {
                    ForEach(0..<clubListVM.clubs2.count, id: \.self){
                        Text(clubListVM.clubs2[$0].wrappedName)
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .club)
                    }
                }



                Picker("Select course", selection: $addGameVM.pickedCourse) {
                    ForEach(0..<(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.count ?? 0), id: \.self){
                        Text(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: $0)?.name ?? "")
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .course)
                    }
                }

                Picker("Default tees for game", selection: $addGameVM.pickedTeeBox){
                    ForEach(0..<(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.count ?? 0), id: \.self){
                        Text(clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: $0)?.wrappedColour ?? "")
                            .tag($0)
                            .focused($AddGameViewInFocus, equals: .teebox)
                    }
                }
                
                Picker("Game duration", selection: $addGameVM.pickerGameDuration){
                    ForEach(GameDuration.allCases, id: \.self){
                        Text($0.stringValue())
                            .tag($0.rawValue)
                    }
                }
                
                Picker("Starting hole", selection: $addGameVM.pickerStartingHole){
                    ForEach(1..<19){
                        Text($0.formatted())
                            .tag($0)
                    }
                }
                
                
                
            }
            Section {
                
                ForEach(playerListVM.players.filter({$0.selectedForGame == true}), id: \.self){player in
                    AddGamePlayerRowItem(player: player)

                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {
                        togglePlayerSelected(player: player)
                        
                      
                } label: {
                Label("Mute", systemImage: "person.fill.badge.minus")
            }
            .tint(.red)
                    
                    
                                                }
                }
                
            }
            
        header: {
            
            Text("PLAYERS ADDED TO THE GAME")
                .foregroundColor(.orange)
        } footer: {
            Text("Remove players by swiping to the left.")
                .foregroundColor(.orange)
                
            
        }
    
            Section {
         
                ForEach(playerListVM.players.filter({$0.selectedForGame == false}), id: \.self){player in
                    AddGamePlayerRowItem(player: player)

                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {
                        togglePlayerSelected(player: player)
                        
                      
                } label: {
                Label("Mute", systemImage: "person.fill.badge.plus")
            }
            .tint(.indigo)
                    
                    
                                                }
                }
                
           
            
        }
    header: {
        Text("AVAILABLE PLAYERS")
            .foregroundColor(.green)
    }
    footer: {
        Text("Add players by swiping to the left.")
            .foregroundColor(.green)
    }
            
            Section{
                
           let playerCount = playerListVM.players.filter({$0.selectedForGame == true}).count
                    
                    
                
                
                let filteredGameFormats = GameFormatType.allCases.filter({$0.NoOfPlayers() == playerCount})
                
                
                Picker("Game", selection: $addGameVM.pickerGameFormat){
                    ForEach(filteredGameFormats.sorted(by: {
                        $0.rawValue < $1.rawValue
                    }), id: \.self) {gameFormat in
                        Text(gameFormat.stringValue())
                            .tag(gameFormat)
                    }
                }

         
                
                let filteredScoringFormats = gameListVM.FilterScoreFormats(pickedGameFormatID: addGameVM.pickerGameFormat.rawValue)

                
                Picker("Score format", selection:$addGameVM.pickerScoringFormat){
                    ForEach(filteredScoringFormats, id: \.self){format in
                        
                        Text(format.stringValue())
                            .tag(format)
                    }
                }
                Picker("Handicap",selection: $addGameVM.pickerHandicapFormat){
                    ForEach(HandicapFormat.allCases, id: \.self){format in
                        Text(format.stringValue())
                            .tag(format)
                        
                    }
                }
//                Picker("Play format",selection: $addGameVM.pickerPlayFormat){
//                    ForEach(PlayFormat.allCases, id: \.self){format in
//                        Text(format.stringValue())
//                            .tag(format)
//
//                    }
//                }
               
                
            }
            Section {
                HStack{
                    Spacer()
                    Button("Create game"){
                       createGame()
                    }
                    //.disabled(playerCount == 0)
                    Button("Dismiss"){
                        for player in playerListVM.players.filter({$0.selectedForGame == true}) {
                         
                            player.player.selectedForGame.toggle()
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
            }
            
        }
        
        .onAppear(perform: {

            clubListVM.getAllClubs2()
            playerListVM.getAllPlayers()

        })
        
        .onSubmit {

            if AddGameViewInFocus == .name {
                AddGameViewInFocus = .date
            } else if AddGameViewInFocus == .date {
                AddGameViewInFocus = .club
            } else if AddGameViewInFocus == .club {
                AddGameViewInFocus = .course
            } else if AddGameViewInFocus == .course {
                AddGameViewInFocus = .teebox

            }
        }
        .interactiveDismissDisabled()
    }
}





struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddGameScreen()
            .environmentObject(CurrentGameFormat())
    }
}
