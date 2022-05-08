//
//  ContentView.swift
//  BatteryLevel
//
//  Created by Russell Gordon on 2022-05-08.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    // Will be populated with battery charge level information
    @State private var currentBatteryLevel: Float = 0.0
    
    // Will be populated with the current device orientation
    @State private var orientation = UIDeviceOrientation.unknown
    
    // Will be populated with battery state information
    @State private var batteryState = UIDevice.BatteryState.unknown
    
    //MARK: Computed properties
    var roundedCurrentBatteryLevel: Int {
        return Int((currentBatteryLevel * 100).rounded())
    }
    
    var body: some View {
        VStack {
            Text("Current battery level is: \(roundedCurrentBatteryLevel) %")
                .onBatteryLevelChanged { newLevel in
                    currentBatteryLevel = newLevel
                }

            Text("Battery state is:")
                .padding(.top)
            Group {
                switch batteryState {
                case .unknown:
                    Text("Unknown")
                case .unplugged:
                    Text("Unplugged")
                case .charging:
                    Text("Charging")
                case .full:
                    Text("Full")
                @unknown default:
                    Text("Some other battery state")
                }
            }
            // Uses the custom view modifier to receive the notifications for when the battery state has changed
            .onBatteryStateChanged { newState in
                batteryState = newState
            }

            Text("Device orientation is:")
                .padding(.top)
            Group {
                if orientation.isPortrait {
                    Text("Portrait")
                } else if orientation.isLandscape {
                    Text("Landscape")
                } else if orientation.isFlat {
                    Text("Flat")
                } else {
                    Text("Unknown")
                }
            }
            // Uses the custom view modifier to receive the notifications for when the device orientation has changed
            .onRotate { newOrientation in
                orientation = newOrientation
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
