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
    
    // Tracks what results should be visible currently
    @State private var selectedReminderVisibility: ReminderVisibility = .all
    
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
                                        
                                        if batteryReminder.number == roundedCurrentBatteryLevel && batteryReminder.isNotified == true {
                                            
                                            // Push notification
                                            publishNotification(title: "Reminder:",
                                                                subtitle: "You battery level is \(batteryReminder.number)%",
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
                                                            listOfBatteryLevelReminders: $listOfBatteryLevelReminders)
                            }
                            
                        }
                        .RoundedRectangelOverlay()
                        
                    }
                    
                }
                .padding(.horizontal, 20)
                
                // Your reminders
                Group {
                    
                    HStack {
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("Your Reminders")
                                .bold()
                                .font(.title2)
                            
                            Text("Filtered by: \(selectedReminderVisibility.rawValue)")
                                .foregroundColor(Color.gray)
                                .font(.caption)
                        }
                        
                        Spacer()
                        
                        Menu {
                                
                                // Picker to allow user to select what reminders to show
                                Picker("Filter", selection: $selectedReminderVisibility) {
                                    
                                    Text(ReminderVisibility.notRepeated.rawValue)
                                        .tag(ReminderVisibility.notRepeated)
                                    
                                    Text(ReminderVisibility.repeated.rawValue)
                                        .tag(ReminderVisibility.repeated)
                                    
                                    Text(ReminderVisibility.all.rawValue)
                                        .tag(ReminderVisibility.all)
                                    
                                }
                            
                        } label: {
                            
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                                .resizable()
                                .frame(width: 35,
                                       height: 35)
                                .foregroundColor(Color("seaGreen"))
                                .padding([.trailing, .bottom], 10)
                            
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    ZStack (alignment: .top) {
                        
                        Group {
                            
                            List {
                                
                                ForEach(filter(listOfBatteryLevelReminders, by: selectedReminderVisibility), id: \.self) { batteryLevelReminder in
                                    
                                    SimpleListItemView(title: "\(batteryLevelReminder.number)",
                                                       repeated: batteryLevelReminder.isRecurring,
                                                       pushNotification: batteryLevelReminder.isNotified)
                                    
                                }
                                .onDelete(perform: removeReminders)
                                
                                
                                
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
    
    //MARK: Functions
    // For removing reminders from the list
    func removeReminders(at offsets: IndexSet) {
        
        listOfBatteryLevelReminders.remove(atOffsets: offsets)
        
    }
    
}

struct BatteryView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            LiveBatteryView()
        }
    }
    
    // Create a view to simulate the App Level Entry Point -> BatteryView connection
    struct LiveBatteryView: View {
        
        // Populate some reminders to start
        @State var reminders: [BatteryLevelReminder] = testBatteryLevelReminders
        
        var body: some View {
            
            BatteryView(listOfBatteryLevelReminders: $reminders)
            
        }
        
    }
    
}
