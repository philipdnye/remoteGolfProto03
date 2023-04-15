//
//  TestViewClubArray.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI





struct AddGameScreen: View {
    
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var playerListVM = PlayerListViewModel()
    @Environment(\.presentationMode) var presentationMode

    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
    
   private func createGame () {
        addGameVM.teeBox = clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: addGameVM.pickedTeeBox) ?? TeeBox()

        addGameVM.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
      
        let currentGF = CurrentGameFormat()
       
       
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
            }
            Section {
                
                ForEach(playerListVM.players.filter({$0.selectedForGame == true}), id: \.self){player in
                    HStack{
                        Text(player.firstName)
                        Text(player.lastName)
                        Text(player.player.handicapArray.currentHandicapIndex().formatted())
                        Text(player.selectedForGame.description)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {

                        let manager = CoreDataManager.shared
                    let selectedPlayer = manager.getPlayerById(id: player.id)
                        selectedPlayer?.selectedForGame.toggle()
                       
                        manager.save()
                        playerListVM.getAllPlayers()
                      
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
                    HStack{
                        Text(player.firstName)
                        Text(player.lastName)
                        Text(player.player.handicapArray.currentHandicapIndex().formatted())
                        Text(player.selectedForGame.description)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                    
                    Button {
//                    let index = playerListVM.players.firstIndex(where: {$0 == player}) ?? 0
                        let manager = CoreDataManager.shared
                    let selectedPlayer = manager.getPlayerById(id: player.id)
                        selectedPlayer?.selectedForGame.toggle()
                       
                        manager.save()
                        playerListVM.getAllPlayers()
                      
                } label: {
                Label("Mute", systemImage: "person.fill.badge.plus")
            }
            .tint(.indigo)
                    
                    
                                                }
                }
                //AvailablePlayers()
           
            
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
                Picker("Game", selection: $addGameVM.pickerGameFormat){
                    ForEach(GameFormatType.allCases.sorted(by: {
                        $0.rawValue > $1.rawValue
                    }), id: \.self) {gameFormat in
                        Text(gameFormat.stringValue())
                            .tag(gameFormat)
                    }
                }
                .onAppear(perform: {
                    addGameVM.pickerGameFormat = .fourBallBBMatch
                })

                .onReceive([self.addGameVM.pickerGameFormat].publisher.first()){
                    gameFormat in
                    addGameVM.updateCurrentGameFormat(currentGF: currentGF, gameFormat: gameFormat)

                }
                
                Picker("Score format", selection:$addGameVM.pickerScoringFormat){
                    ForEach(ScoreFormat.allCases, id: \.self){format in
                        
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
                Picker("Play format",selection: $addGameVM.pickerPlayFormat){
                    ForEach(PlayFormat.allCases, id: \.self){format in
                        Text(format.stringValue())
                            .tag(format)
                        
                    }
                }
               
                
            }
            Section {
                HStack{
                    Spacer()
                    Button("Create game"){
                       createGame()
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
    }
}

struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddGameScreen()
    }
}
