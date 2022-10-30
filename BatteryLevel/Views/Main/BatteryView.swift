//
//  BatteryView.swift
//  BatteryLevel
//

import SwiftUI

struct BatteryView: View {
    
    // MARK: Stored properties
    
    // Will be populated with battery charge level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // Will be populated with battery state information
    @State private var batteryState = UIDevice.BatteryState.unknown
    
    // Controls the pop-up sheet
    @State private var showAddBatteryLevelReminder = false
    
    // Keep track of the list of battery level reminder
    @Binding var listOfBatteryLevelReminders: [BatteryLevelReminder]
    
    // MARK: Computed properties
    var roundedCurrentBatteryLevel: Int {
        
        return Int((currentBatteryLevel * 100).rounded())
        
    }
    
    var body: some View {
        
        ZStack {
            
            // Background color
            Color("backgroundGray")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (alignment: .leading, spacing: 20) {
                
                // Current battery level
                Group {
                    Text("Current Battery Level")
                        .bold()
                        .font(.title2)
                        .padding(.leading, 20)
                    
                    HStack {
                        Spacer()
                        
                        // A completion meter for current battery state
                        CompletionMeterView(fillToValue: CGFloat(roundedCurrentBatteryLevel))
                            .padding(.vertical, 15)
                            .onBatteryStateChanged { newState in
                                
                                batteryState = newState
                                
                                print(batteryState)
                                
                            }
                            .onBatteryLevelChanged { newLevel in
                                
                                currentBatteryLevel = newLevel
                                print("Current battery level is \(currentBatteryLevel), rounded to \(roundedCurrentBatteryLevel)")
                                
                                // Only send reminder if battery state is unknown or unplugged
                                if batteryState == .unknown || batteryState == .unplugged {
                                    
                                    // Loop over the list of battery level reminders
                                    for batteryReminder in listOfBatteryLevelReminders {
                                        
                                        print(batteryReminder.number)
                                        
                                        if batteryReminder.number == roundedCurrentBatteryLevel {
                                            
                                            // Push notification
                                            publishNotification(title: "Reminder:",
                                                                subtitle: "You batery level is \(batteryReminder.number)%",
                                                                body: "Consider charging your phone 😉",
                                                                timeUntil: 1,
                                                                identifier: myNotificationsIdentifier)
                                            
                                            // Check if the reminder is not repeated
                                            if batteryReminder.isRecurring == false {
                                                
                                                // Get the index of the battery reminder
                                                let indexOfBatteryReminder = listOfBatteryLevelReminders.firstIndex(of: batteryReminder)
                                                
                                                // Remove the not repeated reminder
                                                listOfBatteryLevelReminders.remove(at: indexOfBatteryReminder ?? 0)
                                                
                                            }
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
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
                
                VStack (alignment: .leading, spacing: 20) {
                    
                    // Add reminders
                    Group {
                        
                        Text("Add Reminders")
                            .bold()
                            .font(.title2)
                        
                        VStack (alignment: .leading, spacing: 20) {
                            
                            Button {
                                
                                showAddBatteryLevelReminder = true
                                
                            } label: {
                                
                                HStack {
                                    
                                    Label("Notify by battery level", systemImage: "plus.circle")
                                        .foregroundColor(Color("teal"))
                                    
                                    Spacer()
                                    
                                }
                                
                            }
                            .sheet(isPresented: $showAddBatteryLevelReminder) {
                                AddBatteryLevelReminderView(showThisView: $showAddBatteryLevelReminder,
                                                            isRepeatedOrNot: "",
                                                            listOfBatteryLevelReminders: $listOfBatteryLevelReminders)
                            }
                            
                        }
                        .RoundedRectangelOverlay()
                        
                    }
                    
                }
                .padding(.horizontal, 20)
                
                // Your reminders
                Group {
                    
                    Text("Your Reminders")
                        .bold()
                        .font(.title2)
                        .padding(.horizontal, 20)
                    
                    ZStack (alignment: .top) {
                        
                        Group {
                            
                            List {
                                
                                ForEach(listOfBatteryLevelReminders.reversed(), id: \.self) { batteryLevelReminder in
                                    
                                    SimpleListItemView(title: "\(batteryLevelReminder.number)%",
                                                       description: batteryLevelReminder.caption,
                                                       pushNotification: batteryLevelReminder.isRecurring)
                                    
                                }
                                .onDelete { index in
                                    
                                    // Get the item from the reversed list
                                    let theItem = listOfBatteryLevelReminders.reversed()[index.first!]
                                    
                                    // Get the index of the item from the original list and remove it
                                    if let newIndex = listOfBatteryLevelReminders.firstIndex(of: theItem) {
                                        listOfBatteryLevelReminders.remove(at: newIndex)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .opacity(listOfBatteryLevelReminders.isEmpty ? 0.0 : 1.0)
                        
                        HStack {
                            
                            Text("You haven't added any reminders")
                            
                            Spacer()
                            
                        }
                        .RoundedRectangelOverlay()
                        .padding(.horizontal, 20)
                        .opacity(listOfBatteryLevelReminders.isEmpty ? 1.0 : 0.0)
                    }
                    
                }
                
            }
            .padding(.vertical, 20)
            .task {
                
                // Required to enable battery information monitoring
                UIDevice.current.isBatteryMonitoringEnabled = true
                
                // Show the device's current battery level once (when app opens)
                currentBatteryLevel = UIDevice.current.batteryLevel
                
            }
            
        }
        .navigationTitle("Battery")
        // Make the nav bar be inlined at top of view
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BatteryView(listOfBatteryLevelReminders: .constant([testBatteryLevelReminder]))
        }
    }
}
