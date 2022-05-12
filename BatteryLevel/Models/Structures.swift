//
//  Article.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import Foundation

/*
 Each instance of this structure corresponds to a single row in this spreadsheet:
 
 https://docs.google.com/spreadsheets/d/1ekuPZOU5hYBEzDPr0lKsJfLa2L10z5OtuRKoWxz9X94/edit?usp=sharing
 
 The `id` property is the row number in the spreadsheet.
 
 The spreadsheet is accessed via this endpoint:
 
 https://api.sheety.co/5cca2c9d2b851afd1532a526e511ea69/batteryArticles/sheet1
 
 */
struct Article: Identifiable, Codable, Hashable {
    
    let id: Int
    let title: String
    let url: String
    
}

struct Articles: Codable {
    
    // Will eventually be populated with data matching all the rows of the spreadsheet
    // Begins as an empty list
    var list: [Article] = []
    
    // Defines the endpoint for reading/writing spreadsheet data
    static let endpoint = "https://api.sheety.co/5cca2c9d2b851afd1532a526e511ea69/batteryArticles/sheet1"
    
}

let testArticles = [Article(id: 2,
                            title: "How do Lithium Batteries Work?",
                            url: "https://batteryuniversity.com/article/bu-204-how-do-lithium-batteries-work")
                    ,
                    Article(id: 3,
                            title: "How to Prolong Lithium-based Batteries?",
                            url: "https://batteryuniversity.com/article/bu-808-how-to-prolong-lithium-based-batteries")
]


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
