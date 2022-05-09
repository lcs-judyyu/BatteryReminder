//
//  BatteryLevelApp.swift
//  BatteryLevel
//
//  Created by Russell Gordon on 2022-05-08.
//

import SwiftUI

@main
struct BatteryLevelApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView {
                BatteryView()
                    .tabItem {
                        Image(systemName: "battery.100.bolt")
                        Text("Battery")
                    }
                
                ReportView()
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("Report")
                    }
            }
            .accentColor(Color("blueGreen"))
            
        }
    }
}
