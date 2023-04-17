//
//  CompetitorRowItem_GameDetail.swift
//  GolfProto03
//
//  Created by Philip Nye on 17/04/2023.
//

import SwiftUI

struct CompetitorRowItem_GameDetail: View {
    var competitor: Competitor
    var body: some View {
        HStack{
            Text(competitor.FirstName())
            Text(competitor.LastName())
            Text(competitor.TeeBoxColour())
            HStack{
                
            }.frame(width:20, height:20)
                .background(Color(competitor.teeBox?.teeBoxColor ?? UIColor(.clear)))
                .border(.black.opacity(0.2))
        }
    }
}

struct CompetitorRowItem_GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        let competitor = CompetitorViewModel(competitor: Competitor(context: CoreDataManager.shared.viewContext)).competitor
        CompetitorRowItem_GameDetail(competitor: competitor)
    }
}
