//
//  BatteryView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

struct BatteryView: View {
    
    // MARK: Stored properties
    // Will be populated with battery charge level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // Will be populated with battery state information
    @State private var batteryState = UIDevice.BatteryState.unknown
    
    // Controls what type of reminder can be added in the pop-up sheet
    @State private var showAddBatteryLevelReminder = false
    @State private var showAddTimeReminder = false
    
    //MARK: Computed properties
    var roundedCurrentBatteryLevel: Int {
        
        return Int((currentBatteryLevel * 100).rounded())
        
    }
    
    var body: some View {
        
        ScrollView {
            
            ZStack {
                
                //Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 20) {
                    
                    //a completion meter for current battery state
                    
                    
                    //Add reminders
                    Group {
                        
                        Text("Add Reminders")
                            .bold()
                            .font(.title2)
                        
                        VStack (alignment: .leading, spacing: 10) {
                            
                            // Pop-up sheet is adapted from the Composable Views and Animations project by Russell Gordon
                            //https://github.com/lcs-rgordon/ComposableViewsAndAnimations
                            Button {
                                
                                showAddBatteryLevelReminder = true
                                
                            } label: {
                                
                                Label("Notify by battery level", systemImage: "plus.circle")
                                    .foregroundColor(Color("teal"))
                                
                            }
                            .sheet(isPresented: $showAddBatteryLevelReminder) {
                                AddBatteryLevelReminderView(showThisView: $showAddBatteryLevelReminder, repeated: true)
                            }
                            
                            Divider()
                            
                            Button {
                                
                                showAddTimeReminder = true
                                
                            } label: {
                                
                                Label("Notify by time", systemImage: "plus.circle")
                                    .foregroundColor(Color("teal"))
                                
                            }
                            .sheet(isPresented: $showAddTimeReminder) {
                                AddTimeReminderView(showThisView: $showAddTimeReminder)
                            }
                            
                        }
                        .RoundedRectangelOverlay()
                        
                    }
                    
                    //your reminders
                    Group {
                        
                        Text("Your Reminders")
                            .bold()
                            .font(.title2)
                        
                        VStack {
                            
                            SimpleListItemView(title: "30%", description: "repeated", pushNotification: true)
                            
                            Divider()
                            
                            SimpleListItemView(title: "22:30", description: "Weekdays", pushNotification: false)
                            
                        }
                        .RoundedRectangelOverlay()
                        
                    }
                    
                }
                .padding(20)
                .task {
                    
                    // Adapted from:
                    // https://www.hackingwithswift.com/example-code/uikit/how-to-read-the-battery-level-of-an-iphone-or-ipad
                    // Required to enable battery information monitoring
                    UIDevice.current.isBatteryMonitoringEnabled = true
                    
                    // Show the device's current battery level once (when app opens)
                    currentBatteryLevel = UIDevice.current.batteryLevel
                }
                
            }
            
        }
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BatteryView()
        }
    }
}
