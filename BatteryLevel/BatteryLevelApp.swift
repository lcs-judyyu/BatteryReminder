//
//  BatteryLevelApp.swift
//  BatteryLevel
//

import SwiftUI

@main
struct BatteryLevelApp: App {

    // Ensure the AppDelegate class instance is connected to the SwiftUI structure instance for the app
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Source of truth of the list of battery level reminder
    @State var listOfBatteryLevelReminders: [BatteryLevelReminder] = []   // Empty list to start
    
    var body: some Scene {
        WindowGroup {
            
            TabView {
                
                NavigationView {
                    BatteryView(listOfBatteryLevelReminders: $listOfBatteryLevelReminders)
                }
                .tabItem {
                    Image(systemName: "battery.100.bolt")
                    Text("Battery")
                }
                
                NavigationView {
                    ReportView()
                }
                .tabItem {
                    Image(systemName: "info.bubble")
                    Text("More Info")
                }
                
            }
            .accentColor(Color("seaGreen"))
            
        }
    }
}
