//
//  Article.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import Foundation

struct Article: Identifiable {
    
    let id = UUID()
    let title: String
    let url: String
    
}

struct Time: Identifiable {
    
    let id = UUID()
    let time: String
    let date: String
    
}

struct BatteryLevelReminder: Identifiable, Hashable {
    
    let id = UUID()
    let number: String
    let isRepeated: String
    
}

let testBatteryLevelReminder = BatteryLevelReminder(number: "30",
                                                    isRepeated: "Repeated")
