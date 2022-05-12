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

struct BatteryLevelReminder: Decodable, Hashable, Encodable {

    let number: Int
    let isRecurring: Bool
    let caption: String
    let isNotified: Bool
    
}

let testBatteryLevelReminder = BatteryLevelReminder(number: 30,
                                                    isRecurring: true,
                                                    caption: "Repeated",
                                                    isNotified: true)

let testBatteryLevelReminders = [
    BatteryLevelReminder(number: 30,
                         isRecurring: true,
                         caption: "Repeated",
                         isNotified: true)
    ,
    BatteryLevelReminder(number: 50,
                         isRecurring: false,
                         caption: "Not Repeated",
                         isNotified: true)
]
