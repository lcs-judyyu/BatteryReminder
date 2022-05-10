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
    
    //list of number options
    let listOfPickerOptions: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
    
    // Keep track of user selected battery level to receive notification
    @State private var selectedBatteryLevel: Int = 30
    
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
                
                VStack {
                    
                    Text("Remind me when battery level is at:")
                        .font(.title3)
                    
                    HStack {
                        Picker("Please choose a number", selection: $selectedBatteryLevel) {
                            
                            ForEach(listOfPickerOptions, id: \.self) {
                                Text("\($0)")
                            }
                            
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Text("%")
                    }
                    
                }
                .RoundedRectangelOverlay()
                
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

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BatteryView()
        }
    }
}
