//
//  SharedFunctions.swift
//  BatteryLevel
//

import Foundation
import os
import UserNotifications

// Purpose: These two functions combined allow local notifications to be scheduled by the application

// Invoke this function once prior to the first time a notification needs to be published
func askNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
        if success {
            Logger().notice("Permission to receive notifications has been granted by the user.")
        } else if let error = error {
            Logger().notice("\(error.localizedDescription)")
        }
    }
}

// Publish a local notification that runs after a specified wait time in seconds; creates a non-repeating notification
/// - Parameters:
///   - title: The title of the notification; should be kept brief.
///   - subtitle: The subtitle of the notification; should be kept brief.
///   - body: The body of the notification; can be somewhat longer.
///   - timeUntil: A length of time, measured in seconds, until the notification will be published.
///   - identifier: A unique identifier for notifications published by this app.
func publishNotification(title: String,
                         subtitle: String,
                         body: String,
                         timeUntil: Double,
                         identifier: String = UUID().uuidString) {
    
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.body = body
    content.sound = UNNotificationSound.default
    
    // Show this notification x number of seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeUntil, repeats: false)
    
    // Choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
    // Add notification request
    UNUserNotificationCenter.current().add(request)
    
    // Report
    Logger().notice("Notification has been scheduled.")
    
}

// Return the location of the Documents directory for the app
func getDocumentsDirectory() -> URL{
    let paths = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)
    
    // Return the first path
    return paths[0]
}

// Filter the list of reminders to be shown
func filter(_ listOfReminders: [BatteryLevelReminder], by visibility: ReminderVisibility) -> [BatteryLevelReminder] {
    
    // When the user wants to see all results, just return the list provided
    if visibility == .all {
        
        return listOfReminders
        
    } else {
        
        // Create an empty list of results
        var filteredReminders: [BatteryLevelReminder] = []
        
        // Iterate over the list of results, and build a new list that only includes the selected type of reminders
        for currentReminder in listOfReminders {
            
            if visibility == .repeated && currentReminder.isRecurring == true {
                
                filteredReminders.append(currentReminder)
                
            } else if visibility == .notRepeated && currentReminder.isRecurring == false {
                
                filteredReminders.append(currentReminder)
                
            }
            
        }
        
        // Return the filtered list of reminders
        return filteredReminders
    }
    
}
