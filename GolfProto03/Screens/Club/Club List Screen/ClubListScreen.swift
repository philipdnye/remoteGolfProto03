//
//  ClubListScreen.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import SwiftUI

struct ClubListScreen: View {
    @StateObject private var clubListVM = ClubListViewModel()
    @State private var isPresented: Bool = false
    @State private var needsRefresh: Bool = false

    
    private func deleteClub(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let club = clubListVM.clubs[index]
            // delete the club
            clubListVM.deleteClub(club: club)
            // get all clubs
            clubListVM.getAllClubs1()
            
            
         
        }
    }
    
    private func onAdd() {
        isPresented = true
    }
   
    private var addButton: some View {
       AnyView(Button(action: onAdd) {Image(systemName: "plus")})
        }
    
    
    var body: some View {
        
        NavigationStack{
            List {
                
                ForEach(clubListVM.clubs, id: \.id) { club in
                    
                    NavigationLink(
                        destination: CourseListScreen(club: club, needsRefresh: $needsRefresh)) {
                            
                            
                            ClubListRowItem(needsRefresh: $needsRefresh,club: club)
                            
                            
                        }
                    
                }
                .onDelete(perform: deleteClub)
                //            .sheet(isPresented: $isPresentedEdit, content: {EditClubScreen(club: clubEdit)})
                
                
                
            }
            
            .listStyle(PlainListStyle())
            //            .navigationTitle("Clubs")
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton
                }
                
                
                
            }
            
            
            
            .sheet(isPresented: $isPresented, onDismiss: {
                clubListVM.getAllClubs1()
            }, content: {
                AddClubScreen()
            })
            //            .embedInNavigationView()
            
            .onAppear(perform: {
                clubListVM.getAllClubs1()
                
            })
            //        .accentColor(needsRefresh ? .white: .black)
        }
        }
}

struct ClubListScreen_Previews: PreviewProvider {
    static var previews: some View {
       
        ClubListScreen()
    }
}
