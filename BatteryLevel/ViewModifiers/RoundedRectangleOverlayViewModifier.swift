//
//  RoundedRectangleOverlayViewModifier.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-09.
//

import Foundation
import SwiftUI

//Source: https://useyourloaf.com/blog/swiftui-custom-view-modifiers/
struct RoundedRectangleOverlayViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(15)
        //Source: https://www.appcoda.com/swiftui-card-view/
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
            )
    }
    
}

extension View {
    
    func RoundedRectangelOverlay() -> some View {
        modifier(RoundedRectangleOverlayViewModifier())
    }
    
}

