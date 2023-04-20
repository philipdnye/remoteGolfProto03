//
//  GameDetailScreen2.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct GameDetailScreen2: View {
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var gameListVM = GameListViewModel()
    @EnvironmentObject var currentGF: CurrentGameFormat
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isPresented: Bool = false
    @State private var isPresentedHcap: Bool = false
    @State private var needsRefresh: Bool = false
    
    @State private var isShowingDialogueTrash:Bool = false
    @State private var isShowingDialogueScoreEntry:Bool = false
    @State private var showingSheetScorecard: Bool = false
    @State private var gotoScoreEntry: Bool = false
    @State private var showingSheetHandicapCalc: Bool = false
   
    func OnAppear() {
        gameListVM.getAllGames()

        gameListVM.updateCurrentGameFormat(currentGF: currentGF, game: game.game)

    }
    private func onAdd() {
        
        isPresented.toggle()
    }
    
    private func onAddHcap() {
        
        isPresentedHcap.toggle()
    }
    private func UpdateCompetitorTeam(competitor: Competitor, value: Int16) {
        let manager = CoreDataManager.shared
        let competitorId = competitor.objectID
        let currentCompetitor = manager.getCompetitorById(id: competitorId)
        currentCompetitor?.team = value
        manager.save()
        needsRefresh.toggle()
        gameListVM.getAllGames()
        gameListVM.getAllCompetitors()
    }
    
    private var scoreEntryButton: some View {
        AnyView(Button(action: showScoreEntry){
//            let CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
            if game.gameStarted == true {
                
                switch game.gameFinished {
                case false:
                    Text("Resume game")
                case true:
                    Text("Scorecard")
                }
            } else {
                
                Text("Start game")
               
            }
            
            
        })//{Image(systemName: "list.number")})
    }
    
    private func showScoreEntry() {
//        let CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
        if game.gameStarted == false {
            isShowingDialogueScoreEntry.toggle()
        } else {
            
            switch game.gameFinished {
            case true:
                //code here to launch the scorecard
                print("game finished")
                showingSheetScorecard.toggle()
            case false:
                gotoScoreEntry.toggle()
            }
        }
    }
    
    private var handicapCalcButton: some View {
        AnyView(Button(action: showHandicapCalc){
            Image(systemName: "h.circle")
                .foregroundColor(darkTeal)
            
        })
    }
    
    private func showHandicapCalc() {
        showingSheetHandicapCalc.toggle()
    }
    private var trashButton: some View {
       
        AnyView(Button(action: deleteGame){Image(systemName: "trash")})
            
    }
    
    private func deleteGame() {
//        let CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
//        if games.allGames[CGI].gameStarted != true {
            isShowingDialogueTrash = true
//        }
    }
    
    
    let game: GameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
//            Text(needsRefresh.description)
            GameSummaryForDetailScreen(game: game)
            HStack{
                VStack{
                    Text("Team A: \(game.game.teamAPlayingHandicap.formatted())")
                    Text("Team B: \(game.game.teamBPlayingHandicap.formatted())")
                    Text("Team C: \(game.game.teamCPlayingHandicap.formatted())")
                }
                VStack{
                    Text("Team A: \(game.game.teamAShotsReceived.formatted())")
                    Text("Team B: \(game.game.teamBShotsReceived.formatted())")
                    Text("Team C: \(game.game.teamCShotsReceived.formatted())")
                }
            }
            Form{
                Section {
              
                    ForEach(Array(game.game.competitorArray.sorted(by:
                                                                    {$0.team < $1.team}
                                                                   
                                                                  )), id: \.self){competitor in
                    CompetitorRowItem_GameDetail(competitor: competitor, needsRefresh: $needsRefresh)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false){
                            Button{
                                currentGF.swipedCompetitor = competitor
                                onAdd()
                            } label: {
                                Text("TeeBox")
                            }
                            .tint(.mint)
                        }
                    
                        .swipeActions(edge: .trailing, allowsFullSwipe: false){
                            Button{
                                currentGF.swipedCompetitor = competitor
                               onAddHcap()
                            } label: {
                                Label("Handicap calculation",systemImage: "h.circle")
                            }
                            .tint(darkTeal)
                        }
                    
                    
                        .swipeActions(edge: .leading,allowsFullSwipe: false) {
                            Button {
                                UpdateCompetitorTeam(competitor: competitor, value: 1)
                                
                                addGameVM.AssignPlayingHandicaps (game: game.game, currentGF: currentGF)
                                addGameVM.AssignTeamPlayingHandicap(game: game.game, currentGF: currentGF)
                                addGameVM.AssignShotsReceived(game: game.game, currentGF: currentGF)
                                
                                let manager = CoreDataManager.shared
                                manager.save()
                                needsRefresh.toggle()
                                gameListVM.getAllGames()
                                gameListVM.getAllCompetitors()
                                
                                
                                
                                print(game.game.competitorArray.filter{$0.team == 1}.count)
                            } label: {
                                Label("Swap team",systemImage: "a.circle")
                            }
                            .tint(.gray)
                           
                            .disabled(competitor.team == TeamAssignment.teamA.rawValue || currentGF.assignTeamGrouping != Assignment.TeamsAB || game.game.competitorArray.filter{$0.team == 1}.count > 2 || game.gameStarted)
                            
                        }
                        .swipeActions(edge: .leading,allowsFullSwipe: false) {
                            Button {
                                UpdateCompetitorTeam(competitor: competitor, value: 2)
                                addGameVM.AssignPlayingHandicaps (game: game.game, currentGF: currentGF)
                                addGameVM.AssignTeamPlayingHandicap(game: game.game, currentGF: currentGF)
                                addGameVM.AssignShotsReceived(game: game.game, currentGF: currentGF)
                               
                                let manager = CoreDataManager.shared
                                manager.save()
                                needsRefresh.toggle()
                                gameListVM.getAllGames()
                                gameListVM.getAllCompetitors()
                                
                                
                                    print(game.game.competitorArray.filter{$0.team == 2}.count)
                            } label: {
                                Label("Swap team",systemImage: "b.circle")
                            }
                            .tint(.blue)
                           
                            .disabled(competitor.team == TeamAssignment.teamB.rawValue || currentGF.assignTeamGrouping != Assignment.TeamsAB || game.game.competitorArray.filter{$0.team == 2}.count > 2 || game.gameStarted)
                            
                        }
                    
                    
                    
                    
                    
                }
            } //section
            header: {
                         
                         Text("Players in this game")
                     } footer: {
                         VStack{
                             Text("Swipe LEFT to change the players teebox")
                             Text("Swipe RIGHT to assign TEAMS")
                         }
                     }
            }
           
        }
        
                .sheet(isPresented: $isPresented, onDismiss: {
                    gameListVM.getAllGames()
                    
                }, content: {
                    ChangeCompetitorTeeBoxSheet(competitor: currentGF.swipedCompetitor, game: game, isPresented: $isPresented, neeedsRefresh: $needsRefresh)
                        .presentationDetents([.fraction(0.25)])
                })
        
                .sheet(isPresented: $isPresentedHcap, onDismiss: {
                    
                }, content: {
                    CourseHandicapCalcScreen(isPresentedHcap: $isPresentedHcap, competitor: currentGF.swipedCompetitor)
                        .presentationDetents([.fraction(0.4)])
                })
        
        
        .onAppear(perform: {
           OnAppear()
        })
        
        .confirmationDialog(
                    "If you start this game, you will not be able to amend any settings. Are you sure you want to continue?",
                    isPresented: $isShowingDialogueScoreEntry
                ) {
                    Button("Start game", role: .destructive) {
//                            scoreEntryVar.CGI = games.allGames.firstIndex(where: {$0 == game}) ?? 0
                        //print("STart button \(scoreEntryVar.CGI)")
                        
//                            games.AssignTeamPlayingHandicap(game: &games.allGames[CGI])
//                            games.AssignExtraShots(game: &games.allGames[CGI])
//                            games.AssignTeamExtraShots(game: &games.allGames[CGI])
//                            games.AssignShotsReceived(game: &games.allGames[CGI])
//                            games.AssignTeamsTeeBox(game: &games.allGames[CGI])
//                            games.saveGamesFM()
                        
                        
//                            games.saveGamesFM()

//                            self.presentationMode.wrappedValue.dismiss()
                        gotoScoreEntry.toggle()
                    }
                } message: {
                    Text("If you start this game, you will not be able to amend any settings. Are you sure you want to continue?")
                }
        
                .confirmationDialog(
                            "Permanently delete this game?",
                            isPresented: $isShowingDialogueTrash
                        ) {
                            Button("Delete game", role: .destructive) {
    //                            let index = games.allGames.firstIndex(where: {$0 == game}) ?? 0
//                                games.allGames[scoreEntryVar.CGI].deleted = true
//                                games.saveGamesFM()
        
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        } message: {
                            Text("You cannot undo this action.")
                        }
        
        
        
                .navigationBarItems(
                                    leading:trashButton,
                                    trailing: HStack{
                                        handicapCalcButton
                                        scoreEntryButton
                                        }
                )
        
        
        
    }
}

struct GameDetailScreen2_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen2(game:game)
            .environmentObject(CurrentGameFormat())
    }
}
