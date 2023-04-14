//
//  SelectTeeBoxScreen.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import SwiftUI

struct SelectTeeBoxScreen: View {
    let club: ClubViewModel
    @StateObject var courseListVM = CourseListViewModel()
    @StateObject var addGameVM = AddGameViewModel()
    @StateObject var teeBoxListVM = TeeBoxListViewModel()
    @Binding var needsRefresh: Bool
   
    var body: some View {
        
        VStack{
            Picker("Select course", selection: $addGameVM.selectedCourse){
                Text("Select course").tag(Optional<Course>(nil))
                ForEach(courseListVM.courses, id: \.self){
                    Text($0.name)
                        .tag(Optional($0.course))
                }
            }
            
            
            //        Picker("Select teebox", selection: $addGameVM.selectedTeeBox){
            //                        Text("Select teebox").tag(Optional<TeeBox>(nil))
            //            ForEach(addGameVM.selectedCourse.course.teeBoxes? as <TeeBox>){teebox in
            //                            Text(teebox.colour)
            //                                .tag(Optional(teebox.teeBox))
            //                        }
            //                    }
            
            NavigationLink(value: addGameVM.selectedCourse, label: {Text("Select default teeBox")})
                .navigationDestination(for: CourseViewModel.self){course in
                    SelectTeeBoxScreen2(course: course,needsRefresh: $needsRefresh)
                }
            
            
            
            
            
            .onAppear(perform: {
                courseListVM.getCoursesByClub(vm: club)
                
            })
        }
    }
}

struct SelectTeeBoxScreen_Previews: PreviewProvider {
    static var previews: some View {
        let club = ClubViewModel(club: Club(context: CoreDataManager.shared.viewContext))
       
        SelectTeeBoxScreen(club: club, needsRefresh: .constant(false))
    }
}
