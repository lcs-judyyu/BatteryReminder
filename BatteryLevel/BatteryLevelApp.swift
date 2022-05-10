//
//  BatteryLevelApp.swift
//  BatteryLevel
//
//  Created by Russell Gordon on 2022-05-08.
//

import SwiftUI

@main
struct BatteryLevelApp: App {
    
    // Adapted from the Local Notifications Example project by Russell Gordon
    // Ensure the AppDelegate class instance is connected to the SwiftUI structure instance for the app
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            
            TabView {
                
                BatteryView()
                .tabItem {
                    Image(systemName: "battery.100.bolt")
                    Text("Battery")
                }
                
                NavigationView {
                    ReportView()
                }
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Report")
                }
                
            }
            .accentColor(Color("seaGreen"))
            
        }
    }
}
