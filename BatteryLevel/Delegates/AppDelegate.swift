//
//  AppDelegate.swift
//  BatteryLevel
//

// Adapted from the Local Notifications Example project by Russell Gordon
import Foundation
import os
import UserNotifications
import SwiftUI

// Required to register for receiving notifications while the app is in the foreground
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // This function runs once when the app finishes launching
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Register to receive notifications
        UNUserNotificationCenter.current().delegate = self
        Logger().notice("Delegate for UNUserNotificationCenter has been set.")
        
        // Ask for permission to send notifications.
        // This will only present a dialog to the user if the app has never asked before.
        askNotificationPermission()
        
        return true
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Run when a notification is received
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Make the notification appear by invoking the completion handler
        // NOTE: Notification will not appear when device is in "Do Not Disturb" mode.
        completionHandler([.alert, .badge, .sound])
    }
}
