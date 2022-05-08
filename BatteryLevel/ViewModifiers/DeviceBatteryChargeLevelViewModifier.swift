//
//  DeviceBatteryChargeLevelViewModifier.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import Foundation
import SwiftUI

// Our custom view modifier to receive notifications about when battery charge level changes
// SEE:
// https://www.hackingwithswift.com/example-code/uikit/how-to-read-the-battery-level-of-an-iphone-or-ipad
// AND:
// https://developer.apple.com/documentation/uikit/uidevice
// AND ADAPTED FROM:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

struct DeviceBatteryChargeLevelViewModifier: ViewModifier {
    
    let action: (Float) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)) { _ in
                action(UIDevice.current.batteryLevel)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onBatteryLevelChanged(perform action: @escaping (Float) -> Void) -> some View {
        self.modifier(DeviceBatteryChargeLevelViewModifier(action: action))
    }
}
