//
//  ReminderVisibility.swift
//  BatteryLevel
//
//  Created by Judy YU on 2022-11-01.
//

import Foundation

// Determine what reminders should be visible in the list of reminders
enum ReminderVisibility: String {
    
    case all = "All"
    case repeated = "Repeated"
    case notRepeated = "Not Repeated"
    
}
