//
//  AddGameScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct AddGameScreen: View {
    
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    
    @State private var showSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Form{
            TextField("Enter name for this game",text: $addGameVM.name)
            DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
        Text("Game played on: ")
        
    }
            Picker("Select club", selection: $addGameVM.selectedClub) {
                ForEach(clubListVM.clubs, id: \.self){
                    Text($0.name)
                        .tag($0.club)
//                        .focused($AddGameViewInFocus, equals: .club)
                }
            }
//            Text("\(addGameVM.selectedClub.name)")
        HStack{
            Spacer()
            Button("Save") {
                
                addGameVM.save()
                presentationMode.wrappedValue.dismiss()
            }
            
            Spacer()
        }
    }
    .navigationTitle("Add Game")
    .onAppear(perform: {
        clubListVM.getAllClubs1()

    })
    }
}

struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddGameScreen()
        }
    }
}
