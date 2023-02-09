//
//  DeviceBatteryStateViewModifier.swift
//  BatteryLevel
//

import Foundation
import SwiftUI

// Adapted from: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
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

