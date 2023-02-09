//
//  DeviceBatteryChargeLevelViewModifier.swift
//  BatteryLevel
//

import Foundation
import SwiftUI

// Adapted from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
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
