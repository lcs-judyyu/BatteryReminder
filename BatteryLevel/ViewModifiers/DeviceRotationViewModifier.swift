//
//  DeviceRotationViewModifier.swift
//  BatteryLevel
//
//  Created by Russell Gordon on 2022-05-08.
//

import Foundation
import SwiftUI

// SOURCE:
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
