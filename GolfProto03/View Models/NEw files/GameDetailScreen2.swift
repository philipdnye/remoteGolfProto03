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
    
    @State private var isPresented: Bool = false
    @State private var isPresentedHcap: Bool = false
    @State private var needsRefresh: Bool = false
    

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
                                Label("Mute",systemImage: "a.circle")
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
                                Label("Mute",systemImage: "b.circle")
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
    }
}

struct GameDetailScreen2_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameViewModel(game: Game(context: CoreDataManager.shared.viewContext))
        GameDetailScreen2(game:game)
            .environmentObject(CurrentGameFormat())
    }
}
