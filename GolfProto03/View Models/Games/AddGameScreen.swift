//
//  AddGameScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

struct AddGameScreen: View {
    
    @StateObject private var addGameVM = AddGameViewModel()
    @State private var showSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        Form{
            TextField("Enter name for game",text: $addGameVM.name)
            DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
        Text("Date of game")
        
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
    }
}

struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddGameScreen()
        }
    }
}
