//
//  DeviceBatteryStateViewModifier.swift
//  BatteryLevel
//
//  Created by Russell Gordon on 2022-05-08.
//

import Foundation
import SwiftUI

// Our custom view modifier to receive notifications about when battery state changes
// SEE:
// https://www.hackingwithswift.com/example-code/uikit/how-to-read-the-battery-level-of-an-iphone-or-ipad
// AND:
// https://developer.apple.com/documentation/uikit/uidevice
// AND ADAPTED FROM:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
struct DeviceBatteryStateViewModifier: ViewModifier {
    let action: (UIDevice.BatteryState) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification)) { _ in
                action(UIDevice.current.batteryState)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onBatteryStateChanged(perform action: @escaping (UIDevice.BatteryState) -> Void) -> some View {
        self.modifier(DeviceBatteryStateViewModifier(action: action))
    }
}

