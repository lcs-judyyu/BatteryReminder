//
//  BatteryView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

struct BatteryView: View {
    
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
        
        ZStack {
            
            //Background color
            Color("backgroundGray")
                .edgesIgnoringSafeArea(.all)
            
            
            VStack (alignment: .leading, spacing: 20) {
                
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
                
                VStack (alignment: .leading, spacing: 20) {
                    
                    //Add reminders
                    Group {
                        
                        Text("Add Reminders")
                            .bold()
                            .font(.title2)
                        
                        VStack (alignment: .leading, spacing: 20) {
                            
                            // Pop-up sheet is adapted from the Composable Views and Animations project by Russell Gordon
                            //https://github.com/lcs-rgordon/ComposableViewsAndAnimations
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
                
                //your reminders
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
                                                       pushNotification: batteryLevelReminder.isNotified)
                                    
                                }
                                .onDelete { index in
                                    
                                    //Source: https://stackoverflow.com/questions/70059435/how-to-handle-ondelete-for-swiftui-list-array-with-reversed
                                    // get the item from the reversed list
                                    let theItem = listOfBatteryLevelReminders.reversed()[index.first!]
                                    
                                    // get the index of the item from the original list and remove it
                                    if let newIndex = listOfBatteryLevelReminders.firstIndex(of: theItem) {
                                        listOfBatteryLevelReminders.remove(at: newIndex)
                                        
                                    }
                                    
                                    //save the new list
                                    persistListOfBatteryLevelReminders()
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
                
                // Adapted from:
                // https://www.hackingwithswift.com/example-code/uikit/how-to-read-the-battery-level-of-an-iphone-or-ipad
                // Required to enable battery information monitoring
                UIDevice.current.isBatteryMonitoringEnabled = true
                
                // Show the device's current battery level once (when app opens)
                currentBatteryLevel = UIDevice.current.batteryLevel
                
                //load the list of battery level reminders from saved file
                loadListOfBatteryLevelReminders()
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .active{
                    print("Active")
                } else {
                    print("Background")
                    
                    //permanently save the list of battery level reminders
                    persistListOfBatteryLevelReminders()
                }
            }
            
        }
        .navigationTitle("Battery")
        // Make the nav bar be "small" at top of view
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    //function for saving the list of battery level reminders permanently
    func persistListOfBatteryLevelReminders() {
        //get a location to save data
        let filename = getDocumentsDirectory().appendingPathComponent(savedBatteryLevelRemindersLabel)
        print(filename)
        
        //try to encodr data to JSON
        do {
            let encoder = JSONEncoder()
            
            //configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            //Encode the list of favourites
            let data = try encoder.encode(listOfBatteryLevelReminders)
            
            //write JSON to a file in the filename location
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            //see the data
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favourites to the document directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
    //function for reloading the list of battery level reminders
    func loadListOfBatteryLevelReminders() {
        let filename = getDocumentsDirectory().appendingPathComponent(savedBatteryLevelRemindersLabel)
        print(filename)
        
        do {
            //load raw data
            let data = try Data(contentsOf: filename)
            
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
            //decode JSON into Swift native data structures
            //NOTE: [] are used since we load into an array
            listOfBatteryLevelReminders = try JSONDecoder().decode([BatteryLevelReminder].self, from: data)
            
        } catch {
            print("Could not load the data from the stored JSON file")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BatteryView(listOfBatteryLevelReminders: .constant([testBatteryLevelReminder]))
        }
    }
}
