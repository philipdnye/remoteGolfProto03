//
//  AddEditClubViewModel.swift
//  GolfProto01
//
//  Created by Philip Nye on 14/03/2023.
//

import Foundation
import SwiftUI

class AddEditClubViewModel: ObservableObject {
    
    var name: String = ""
    var addressLine1: String = ""
    var addressLine2: String = ""
    var addressLine3: String = ""
    var addressLine4: String = ""
    var postCode: String = ""
    var distMetric: String = ""
    var eMail: String = ""
    var clubImage: UIImage = UIImage()
    
    func save() {
        let manager = CoreDataManager.shared
        let club = Club(context: manager.persistentContainer.viewContext)
        club.name = name
        club.addressLine1 = addressLine1
        club.addressLine2 = addressLine2
        club.addressLine3 = addressLine3
        club.addressLine4 = addressLine4
        club.postCode = postCode
        club.distMetric = distMetric
        club.email = eMail
        club.clubImage = clubImage
        
        manager.save()
    }
    
//    func update(){
//        let manager = CoreDataManager.shared.viewContext
//        do {
//            try manager.save()
//        } catch {
//            
//        }
//    }
    
}
