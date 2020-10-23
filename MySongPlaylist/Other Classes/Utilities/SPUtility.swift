//
//  SPUtility.swift
//  MySongPlaylist
//
//  Created by Sajan Gandhi on 10/23/20.
//

import Foundation
import RealmSwift

class SPUtility {
    static let shared = SPUtility()
    
    let realm = try! Realm()
    private init(){
        
    }
    
    
    func convertDateInFormat(_ dateToConvert: String, fromFormate: String, toFormate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormate
        let tempdate = dateFormatter.date(from: dateToConvert)
        dateFormatter.dateFormat = toFormate
        if tempdate != nil {
            // Here using numberStyle formatter add suffix for day
            let calendar = Calendar.current
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .ordinal
            let dateComponents = calendar.component(.day, from: tempdate!)
            let day = numberFormatter.string(from: dateComponents as NSNumber)
            return "\(day!) \(dateFormatter.string(from: tempdate!))"
        } else {
            return ""
        }
    }
}
