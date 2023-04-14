//
//  AddGameScreen2.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import SwiftUI

struct AddGameScreen: View {
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Form{
            TextField("Enter name for this game",text: $addGameVM.name)
    
                .keyboardType(.default)
         
            
            DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
                Text("Game played on: ")
             
                
            }
            
            Picker("Played at:", selection: $addGameVM.selectedClub) {
                Text("Select club").tag(Optional<Club>(nil))
                ForEach(Array(clubListVM.clubs), id: \.self){
                    Text($0.name)
                        .tag(Optional($0.club))
                  
                }
            }
            
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
        AddGameScreen()
    }
}
