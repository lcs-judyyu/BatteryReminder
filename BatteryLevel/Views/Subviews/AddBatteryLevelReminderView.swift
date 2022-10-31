//
//  AddBatteryLevelReminderView.swift
//  BatteryLevel
//

import SwiftUI

struct AddBatteryLevelReminderView: View {
    
    // MARK: Stored properties
    
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    // List of number options
    let listOfPickerOptions: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
    
    // Keep track of user selected battery level
    @State var newSelectedBatteryLevel = 30
    
    // Is the new reminder repeated?
    @State var newReminderIsRepeated = true
    
    // Will be populated with battery level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // Keep track of the list of battery level reminder
    @Binding var listOfBatteryLevelReminders: [BatteryLevelReminder]
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                // Background color
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
                            
                            // New reminder
                            let newBatteryLevelReminder = BatteryLevelReminder(number: newSelectedBatteryLevel,
                                                                               isRecurring: newReminderIsRepeated,
                                                                               isNotified: true)
                            
                            // When new reminder is in the list already
                            if listOfBatteryLevelReminders.contains(newBatteryLevelReminder) {
                                
                                // Get the index of the existed reminder
                                let existedReminderIndex = listOfBatteryLevelReminders.firstIndex(where: {$0 == newBatteryLevelReminder})
                                print(existedReminderIndex ?? 0)
                                
                                // Remove the existed reminder
                                listOfBatteryLevelReminders.remove(at: existedReminderIndex ?? 0)
                                
                                listOfBatteryLevelReminders.append(newBatteryLevelReminder)
                                
                                print("This reminder already exist. It is now added to the top of the list.")
                                
                            } else {
                                
                                listOfBatteryLevelReminders.append(newBatteryLevelReminder)
                                
                            }
                            
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
                    
                    // Required to enable battery information monitoring
                    UIDevice.current.isBatteryMonitoringEnabled = true
                    
                    // Show the device's current battery level once (when app opens)
                    currentBatteryLevel = UIDevice.current.batteryLevel
                }
                
            }
            
        }
        
    }
    
    // MARK: Functions
    // Hide this view
    func hideView() {
        showThisView = false
    }
    
}

struct AddBatteryLevelReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBatteryLevelReminderView(showThisView: .constant(true),
                                        listOfBatteryLevelReminders: .constant(testBatteryLevelReminders))
        }
    }
}
