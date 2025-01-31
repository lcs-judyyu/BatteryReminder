//
//  CompletionMeterView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-10.
//

//SOURCE: Composable Views and Animations project by Russell Gordon
//https://github.com/lcs-rgordon/ComposableViewsAndAnimations
import SwiftUI
import UIKit
import Lottie

struct CompletionMeterView: View {
    
    // MARK: Stored properties
    
    // Show completion up to what percentage?
    let fillToValue: CGFloat
    
    // Controls the amount of trim to show, as a percentage
    @State private var completionAmount: CGFloat = 0.0
    
    // Set timer so that completion amount changes on a regular basis
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            Circle()
            // Traces, or makes a trim, for the outline of a shape
                .trim(from: 0, to: completionAmount)
                .stroke(Color("seaGreen"), lineWidth: 26)
                .frame(width: 230, height: 230)
                .rotationEffect(.degrees(-90))
            // When the timer fires, the code in this block will run.
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
            
            //an animation
            //LottieView(animationNamed: "94408-check-mark-success-done-complete-icon")
            
        }
    }
    
}

struct CompletionMeterView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionMeterView(fillToValue: 75)
    }
}

