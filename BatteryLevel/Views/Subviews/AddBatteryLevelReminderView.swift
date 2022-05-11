//
//  AddBatteryLevelReminderView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-10.
//

import SwiftUI

struct AddBatteryLevelReminderView: View {
    
    //MARK: Stored properties
    //Detect when moves between foreground, background, and inactive atates
    @Environment(\.scenePhase) var scenePhase
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    //list of number options
    let listOfPickerOptions: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
    
    // Keep track of user selected battery level to receive notification
    @State var newSelectedBatteryLevel = 30
    
    //is it repeated?
    @State var newReminderIsRepeated = true
    
    @State var isRepeatedOrNot: String
    
    // Will be populated with battery level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // keep track of the list of battery level reminder
    @Binding var listOfBatteryLevelReminders: [BatteryLevelReminder]   // empty list to start
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                //Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack (spacing: 30) {
                    
                    VStack {
                        
                        Text("Remind me when battery level is at:")
                            .font(.title3)
                        
                        HStack {
                            Picker("Please choose a number", selection: $newSelectedBatteryLevel) {
                                
                                ForEach(listOfPickerOptions, id: \.self) {
                                    Text("\($0)")
                                }
                                
                            }
                            .pickerStyle(WheelPickerStyle())
                            
                            Text("%")
                        }
                    }
                    .RoundedRectangelOverlay()
                    
                    Toggle("Repeated", isOn: $newReminderIsRepeated)
                        .font(.title3)
                        .toggleStyle(SwitchToggleStyle(tint: Color("goldDrop")))
                        .RoundedRectangelOverlay()
                    
                    Spacer()
                    
                    Text("Current Battery Level: \(String(format: "%3.0f", (currentBatteryLevel) * 100.0))%")
                    
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Add") {
                            
                            if newReminderIsRepeated == true {
                                isRepeatedOrNot = "Repeated"
                            } else {
                                isRepeatedOrNot = "Not Repeated"
                            }
                            
                            //new
                            let newId = listOfBatteryLevelReminders.count + 1
                            
                            let newBatteryLevelReminder = BatteryLevelReminder(number: newSelectedBatteryLevel,
                                                                               isRecurring: newReminderIsRepeated,
                                                                               caption: isRepeatedOrNot,
                                                                               isNotified: true)
                            //add to the list of reminders
                            listOfBatteryLevelReminders.append(newBatteryLevelReminder)
                            
                            print(listOfBatteryLevelReminders)
                           
                            hideView()
                        }
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            hideView()
                        }
                    }
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
        
    }
    
    // MARK: Functions
    //Hide this view
    func hideView() {
        showThisView = false
    }
}

struct AddBatteryLevelReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddBatteryLevelReminderView(showThisView: .constant(true),
                                    isRepeatedOrNot: "Repeated",
                                    listOfBatteryLevelReminders: .constant([testBatteryLevelReminder]))
    }
}
