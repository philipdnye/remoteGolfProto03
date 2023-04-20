//
//  CompetitorRowItem_GameDetail.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct CompetitorRowItem_GameDetail: View {
    @EnvironmentObject var currentGF: CurrentGameFormat
    var competitor: Competitor
    @Binding var needsRefresh: Bool
    var body: some View {
        HStack(spacing: 0){
            Text(needsRefresh.description)// this refreshes screen when ttebox changed on pop up sheet
                .frame(width:0, height:0)
                .opacity(0)
            
            
            Group{
                Text(competitor.FirstName())
                Spacer()
                    .frame(width: 5)
                Text(competitor.LastName())
                Spacer()
                    .frame(width: 5)
                Text(competitor.handicapAllowance.formatted())
                
            }
            
            
            .foregroundColor(darkTeal)
            .font(.title3)
            //Text(competitor.TeeBoxColour())
            Spacer()
        
                Text("(\(competitor.handicapIndex.formatted()))")
                .foregroundColor(burntOrange)
                .font(.title3)
            
            Spacer()
                 .frame(width: 1)
            
                Text(round(competitor.courseHandicap).formatted())
                .frame(width: 30, alignment: .trailing)
                .foregroundColor(darkTeal)
                .font(.title3)
                //.fontWeight(.semibold)
                
        
           Spacer()
                .frame(width: 5)
            HStack{
                if currentGF.assignTeamGrouping == Assignment.TeamsAB {
                    ZStack{
                        Text(competitor.team_String.stringValueInitial())
                            .font(.headline)
                            .zIndex(2)
                        Circle()
                            .fill(.white)
                          
                            .frame(width: 23, height: 23)
                            .zIndex(1)
                        Circle()
                            .fill(.gray)
                          
                            .frame(width: 24, height: 24)
                            .zIndex(0)
                           
                    }
                }
            }.frame(width:30, height:30)
                .background(Color(competitor.teeBox?.teeBoxColor ?? UIColor(.clear)))
                .border(.black.opacity(0.2))
        }
    }
}

struct CompetitorRowItem_GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        CompetitorRowItem_GameDetail(competitor: competitor, needsRefresh: .constant(false))
            .environmentObject(CurrentGameFormat())
    }
}
