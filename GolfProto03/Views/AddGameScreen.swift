//
//  TestViewClubArray.swift
//  GolfProto03
//
//  Created by Philip Nye on 15/04/2023.
//

import SwiftUI

enum AddGameViewFocusable: Hashable {
    case name
    case date
    case club
    case course
    case teebox
}

func updateCurrentGameFormat (currentGF: CurrentGameFormat,gameFormat: GameFormatType) {
    currentGF.id = gameFormats[gameFormat.rawValue].id
    currentGF.format = gameFormats[gameFormat.rawValue].format
    currentGF.description = gameFormats[gameFormat.rawValue].description
    currentGF.noOfPlayersNeeded = gameFormats[gameFormat.rawValue].noOfPlayersNeeded
    currentGF.playerHandAllowances = gameFormats[gameFormat.rawValue].playerHandAllowances
    currentGF.assignShotsRecd = gameFormats[gameFormat.rawValue].assignShotsRecd
    currentGF.assignTeamGrouping = gameFormats[gameFormat.rawValue].assignTeamGrouping
    currentGF.competitorSort = gameFormats[gameFormat.rawValue].competitorSort
    currentGF.playFormat = gameFormats[gameFormat.rawValue].playFormat
    currentGF.extraShotsTeamAdj = gameFormats[gameFormat.rawValue].extraShotsTeamAdj
    currentGF.bogey = gameFormats[gameFormat.rawValue].bogey
    currentGF.medal = gameFormats[gameFormat.rawValue].medal
    currentGF.stableford = gameFormats[gameFormat.rawValue].stableford
}

struct AddGameScreen: View {
    
    @StateObject private var clubListVM = ClubListViewModel()
    @StateObject private var addGameVM = AddGameViewModel()
    @Environment(\.presentationMode) var presentationMode

    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
    
    var body: some View {
      
        let currentGF = CurrentGameFormat()
       
       
        Form{
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
                    addGameVM.pickerGameFormat = .fourBallBB2P
                })

                .onReceive([self.addGameVM.pickerGameFormat].publisher.first()){
                    gameFormat in
                    updateCurrentGameFormat(currentGF: currentGF, gameFormat: gameFormat)
                    
//                    currentGF.id = gameFormats[gameFormat.rawValue].id
//                    currentGF.format = gameFormats[gameFormat.rawValue].format
//                    currentGF.description = gameFormats[gameFormat.rawValue].description
//                    currentGF.noOfPlayersNeeded = gameFormats[gameFormat.rawValue].noOfPlayersNeeded
//                    currentGF.playerHandAllowances = gameFormats[gameFormat.rawValue].playerHandAllowances
//                    currentGF.assignShotsRecd = gameFormats[gameFormat.rawValue].assignShotsRecd
//                    currentGF.assignTeamGrouping = gameFormats[gameFormat.rawValue].assignTeamGrouping
//                    currentGF.competitorSort = gameFormats[gameFormat.rawValue].competitorSort
//                    currentGF.playFormat = gameFormats[gameFormat.rawValue].playFormat
//                    currentGF.extraShotsTeamAdj = gameFormats[gameFormat.rawValue].extraShotsTeamAdj
//                    currentGF.bogey = gameFormats[gameFormat.rawValue].bogey
//                    currentGF.medal = gameFormats[gameFormat.rawValue].medal
//                    currentGF.stableford = gameFormats[gameFormat.rawValue].stableford
                    
//                    
                    print("id: \(currentGF.id)")
                    print("format: \(currentGF.format)")
                    print("description: \(currentGF.description)")
                    print("noOFPlayers: \(currentGF.noOfPlayersNeeded)")
                    print("playerHandAllowances: \(currentGF.playerHandAllowances)")
                    print("assignShotsRecd: \(currentGF.assignShotsRecd)")
                    print("competitorSort: \(currentGF.competitorSort)")
                    print("playFormat: \(currentGF.playFormat)")
                    print("extraShots: \(currentGF.extraShotsTeamAdj)")
                    print("Stableford: \(currentGF.stableford)")
                    print("Medal: \(currentGF.medal)")
                    print("Bogey: \(currentGF.bogey)")
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
                        addGameVM.teeBox = clubListVM.clubs2.getElement(at: addGameVM.pickedClub)?.courseArray.getElement(at: addGameVM.pickedCourse)?.teeBoxArray.getElement(at: addGameVM.pickedTeeBox) ?? TeeBox()

                        addGameVM.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                }
            }
            
        }
        
        .onAppear(perform: {

            clubListVM.getAllClubs2()

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
