//
//  CompetitorRowItem_GameDetail.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct CompetitorRowItem_GameDetail: View {
    
    var competitor: Competitor
    @Binding var needsRefresh: Bool
    var body: some View {
        HStack{
            Text(needsRefresh.description)// this refreshes screen when ttebox changed on pop up sheet
                .frame(width:0, height:0)
                .opacity(0)
            
            
            Group{
                Text(competitor.FirstName())
                Text(competitor.LastName())
                Spacer()
                    .frame(width: 5)
                Text(competitor.team_String.stringValueInitial())
            }
            
            
            .foregroundColor(darkTeal)
            .font(.title2)
            //Text(competitor.TeeBoxColour())
            Spacer()
        
                Text("(\(competitor.handicapIndex.formatted()))")
                .foregroundColor(burntOrange)
                .font(.title3)
            
            Spacer()
                 .frame(width: 5)
            
                Text(round(competitor.courseHandicap).formatted())
                .frame(width: 30, alignment: .trailing)
                .foregroundColor(darkTeal)
                .font(.title3)
                .fontWeight(.semibold)
                
        
           Spacer()
                .frame(width: 5)
            HStack{
                
            }.frame(width:25, height:25)
                .background(Color(competitor.teeBox?.teeBoxColor ?? UIColor(.clear)))
                .border(.black.opacity(0.2))
        }
    }
}

struct CompetitorRowItem_GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        CompetitorRowItem_GameDetail(competitor: competitor, needsRefresh: .constant(false))
    }
}
