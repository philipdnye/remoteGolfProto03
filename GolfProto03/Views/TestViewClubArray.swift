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

struct TestViewClubArray: View {
    
    @StateObject private var clubListVM = ClubListViewModel()

    @State private var newGameClubIndex: Int = 0
    @State private var newGameCourseIndex: Int = 0
    @State private var newGameTeeBoxIndex: Int = 0

    @FocusState private var AddGameViewInFocus: AddGameViewFocusable?
    
    var body: some View {
      
        List{
            
    
            
            Picker("Select club", selection: $newGameClubIndex) {
                ForEach(0..<clubListVM.clubs2.count, id: \.self){
                    Text(clubListVM.clubs2[$0].wrappedName)
                        .tag($0)
                        .focused($AddGameViewInFocus, equals: .club)
                }
            }


            
            Picker("Select course", selection: $newGameCourseIndex) {
                ForEach(0..<(clubListVM.clubs2.getElement(at: newGameClubIndex)?.courseArray.count ?? 0), id: \.self){
                    Text(clubListVM.clubs2.getElement(at: newGameClubIndex)?.courseArray.getElement(at: $0)?.name ?? "")
                        .tag($0)
                        .focused($AddGameViewInFocus, equals: .course)
                }
            }
            
            Picker("Select teebox", selection: $newGameTeeBoxIndex){
                ForEach(0..<(clubListVM.clubs2.getElement(at: newGameClubIndex)?.courseArray.getElement(at: newGameCourseIndex)?.teeBoxArray.count ?? 0), id: \.self){
                    Text(clubListVM.clubs2.getElement(at: newGameClubIndex)?.courseArray.getElement(at: newGameCourseIndex)?.teeBoxArray.getElement(at: $0)?.wrappedColour ?? "")
                        .tag($0)
                        .focused($AddGameViewInFocus, equals: .teebox)
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

struct TestViewClubArray_Previews: PreviewProvider {
    static var previews: some View {
        TestViewClubArray()
    }
}
