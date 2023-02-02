//
//  CompletionMeterView.swift
//  BatteryLevel
//

import SwiftUI
import UIKit

struct CompletionMeterView: View {
    
    // MARK: Stored properties
    
    // Show completion up to x percentage
    let fillToValue: CGFloat
    
    // Controls the amount of trim to show, as a percentage
    @State private var completionAmount: CGFloat = 0.0
    
    // Set timer so that completion amount changes on a regular basis
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            Circle()
            // Trim for the outline of a shape
                .trim(from: 0, to: completionAmount)
                .stroke(Color("seaGreen"), lineWidth: 24)
                .frame(width: 230, height: 230)
                .rotationEffect(.degrees(-90))
            // When the timer fires, run the code
                .onReceive(timer) { _ in
                    
                    // Stop the timer
                    timer.upstream.connect().cancel()
                    
                    // Animate the trim being closed
                    withAnimation(.easeInOut(duration: 1.5)) {
                        
                        completionAmount = fillToValue / 100.0
                        
                    }
                    
                }
            
            Text("\(Int(fillToValue))%")
                .font(Font.custom("Courier-Bold", size: 45.0))
                .animation(.default)
            
        }
        .padding(.vertical)
    }
    
}

struct CompletionMeterView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionMeterView(fillToValue: 80)
    }
}

