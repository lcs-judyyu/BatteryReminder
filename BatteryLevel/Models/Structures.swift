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

struct BatteryLevelReminder: Decodable, Hashable, Encodable {
    
    let number: Int
    let isRecurring: Bool
    let caption: String
    var isNotified: Bool
    
}

let testBatteryLevelReminder = BatteryLevelReminder(number: 30,
                                                    isRecurring: true,
                                                    caption: "Repeated",
                                                    isNotified: true)
