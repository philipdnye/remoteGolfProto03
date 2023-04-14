//
//  AddGameScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 11/04/2023.
//

import SwiftUI

enum AddGameViewFocusable: Hashable {
    case name
    case date
    case club
    case course
    case teebox
}

struct AddGameScreen: View {
    
    @StateObject private var addGameVM = AddGameViewModel()
    @StateObject private var clubListVM = ClubListViewModel()
    @State private var needsRefresh: Bool = false
    @State private var showSheet = false
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
    @State private var clubPickerCount: Int = 0
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Enter name for this game",text: $addGameVM.name)
                    .focused($AddGameViewInFocus, equals: .name)
                    .keyboardType(.default)
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75){
                            self.AddGameViewInFocus = .club
                        }
                    }
                DatePicker(selection: $addGameVM.date, in: ...Date(),displayedComponents: .date) {
                    Text("Game played on: ")
                        .focused($AddGameViewInFocus, equals: .date)
                    
                }
                Picker("Played at:", selection: $addGameVM.selectedClub) {
                    Text("Select club").tag(Optional<Club>(nil))
                    ForEach(clubListVM.clubs, id: \.self){
                        Text($0.name)
                            .tag(Optional($0.club))
                        //                        .focused($AddGameViewInFocus, equals: .club)
                    }
                }
                
                .task {
                    print(clubPickerCount)
                    clubPickerCount += 1
                    print(clubPickerCount)
                }
                
                //            Picker("Select course", selection: $addGameVM.selectedCourse){
                //                Text("Select course").tag(Optional<Course>(nil))
                //                ForEach(addGameVM.selectedClub.club.course22, id: \.self){
                //                    Text($0.name)
                //                        .tag(Optional($0.course))
                //                }
                //            }
                
                NavigationLink(value: addGameVM.selectedClub, label: {Text("Select default teeBox")})
                    .navigationDestination(for: ClubViewModel.self){club in
                        SelectTeeBoxScreen(club: club,needsRefresh: $needsRefresh)
                    }
                
                HStack{
                    //            Button("Course count"){
                    //                print(addGameVM.selectedClub.club.course22?.count ?? 88)
                    //            }
                    Spacer()
                    Button("Save") {
                        
                        addGameVM.save()
                        presentationMode.wrappedValue.dismiss()
                        
                    }
//                    .disabled(clubPickerCount < 3)
                    //            .disabled(addGameVM.selectedClub == nil)
                    //.disabled(clubPickerCount == 0)
                    Spacer()
                }
                //        .disabled(clubPickerCount < 3)
            }
            .navigationTitle("Add Game")
            .onAppear(perform: {
                clubListVM.getAllClubs1()
                
                //        clubListVM.getAllClubs()
                //        addGameVM.selectedClub = clubListVM.clubs.first!
                //        addGameVM.selectedCourse = addGameVM.selectedClub.club.course22?.allObjects[0] as! CourseViewModel
                //       print(clubListVM.clubs.count)
                
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
//                .onReceive([self.addGameVM.selectedClub].publisher.first()){club in
//            //        print(clubPickerCount)
//                    clubPickerCount += 1
//            //        print(clubPickerCount)
//
//                }
            //        clubVM in
            //        addGameVM.selectedCourse = clubVM.club.course22?.allObjects[0] as! CourseViewModel
            //      //  let actualClub = CoreDataManager.shared.getClubById(id: addGameVM.selectedClub.id)
            ////        addGameVM.save()
            //    }
        }
    }
}

struct AddGameScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            AddGameScreen()
        }
    }
}
