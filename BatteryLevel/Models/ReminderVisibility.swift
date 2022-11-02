//
//  ReminderVisibility.swift
//  BatteryLevel
//

import Foundation

// Determine what reminders should be visible in the list of reminders
enum ReminderVisibility: String {
    
    case all = "All"
    case repeated = "Repeated"
    case notRepeated = "Not Repeated"
    
}
