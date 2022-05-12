//
//  TestListView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-11.
//

import SwiftUI

struct TestListView: View {
    
    // MARK: Stored properties
    //Detect when app moves between foreground, background, and inactive atates
    @Environment(\.scenePhase) var scenePhase
    
    // Will be populated with battery charge level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // Will be populated with battery state information
    @State private var batteryState = UIDevice.BatteryState.unknown
    
    // Controls what type of reminder can be added in the pop-up sheet
    @State private var showAddBatteryLevelReminder = false
    @State private var showAddTimeReminder = false
    
    // keep track of the list of battery level reminder
    @Binding var listOfBatteryLevelReminders: [BatteryLevelReminder] // empty list to start
    
    @State private var repeated = true
    
    //MARK: Computed properties
    var roundedCurrentBatteryLevel: Int {
        
        return Int((currentBatteryLevel * 100).rounded())
        
    }

    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                //Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    //current battery level
                    Group {
                        Text("Current Battery Level")
                            .bold()
                            .font(.title2)
                            .padding(.leading, 20)
                        
                        HStack {
                            Spacer()
                            
                            //a completion meter for current battery state
                            CompletionMeterView(fillToValue: CGFloat(roundedCurrentBatteryLevel))
                                .padding(.vertical, 15)
                                .onBatteryLevelChanged { newLevel in
                                    currentBatteryLevel = newLevel
                                    print("Current battery level is \(currentBatteryLevel), rounded to \(roundedCurrentBatteryLevel)")
                                }
                            
                            Spacer()
                        }
                        .padding(.vertical, 15)
                        .background(Color.white)
                        .overlay(
                            Rectangle()
                                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                        )
                    }
                    
                    
            
                    List {
            
            ForEach(listOfBatteryLevelReminders.reversed(), id: \.self) { batteryLevelReminder in
                
                SimpleListItemView(title: "\(batteryLevelReminder.number)%",
                                   description: batteryLevelReminder.caption,
                                   pushNotification: batteryLevelReminder.isNotified)
                
                        }
            .onDelete(perform: delete)
            }
                    
                }
                .padding(.vertical, 20)
                
            }
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
    
    //a function to delete items in the list
    func delete(at offsets: IndexSet) {
        
        print(offsets)
        listOfBatteryLevelReminders.remove(atOffsets: offsets)
        //persistFavourites()
        
    }
    
}

struct TestListView_Previews: PreviewProvider {
    static var previews: some View {
        TestListView(listOfBatteryLevelReminders: .constant([testBatteryLevelReminder]))
    }
}
