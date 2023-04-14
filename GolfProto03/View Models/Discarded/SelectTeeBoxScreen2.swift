//
//  SelectTeeBoxScreen2.swift
//  GolfProto03
//
//  Created by Philip Nye on 14/04/2023.
//

import SwiftUI

struct SelectTeeBoxScreen2: View {
    
    let course: CourseViewModel
    @StateObject var addGameVM = AddGameViewModel()
    @Binding var needsRefresh: Bool
    @StateObject var teeBoxListVM = TeeBoxListViewModel()
    var body: some View {
        VStack{
            Text(course.name)
            Picker("Select teeBox", selection: $addGameVM.selectedTeeBox){
                Text("Select teebox").tag(Optional<TeeBox>(nil))
                ForEach(teeBoxListVM.teeBoxes, id: \.self){
                    Text($0.colour)
                        .tag(Optional($0.teeBox))
                }
            }
            Button("Save"){
                addGameVM.save()
            }
            
            
                .onAppear(perform: {
                    teeBoxListVM.getTeeBoxesByCourse(vm: course)
                    
                })
//                .onReceive([self.addGameVM.selectedTeeBox].publisher.first()){teeBox in
//                    addGameVM.save()
//            
//                }
            
            
        }
    }
}

struct SelectTeeBoxScreen2_Previews: PreviewProvider {
    static var previews: some View {
        let course = CourseViewModel(course: Course(context: CoreDataManager.shared.viewContext))
        SelectTeeBoxScreen2(course: course, needsRefresh: .constant(false))
    }
}
