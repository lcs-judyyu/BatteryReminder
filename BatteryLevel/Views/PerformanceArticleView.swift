//
//  PerformanceArticleView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

//Source: https://support.apple.com/en-ca/HT208387#:~:text=As%20lithium%2Dion%20batteries%20chemically,to%20when%20it%20was%20new.

struct PerformanceArticleView: View {
    
    //MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .center) {
                Text("Battery and Performance".capitalized(with: .current))
                    .bold()
                    .italic()
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("About lithium-ion batteries")
                        .bold()
                        .font(.title2)
                    
                    Text("""
    Most phone batteries today use lithium-ion technology. Compared with older generations of battery technology, lithium-ion batteries charge faster, last longer, and have a higher power density for more battery life in a lighter package.
    """)
                    
                    Image("Charge2")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 20)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("When batteries chemically age")
                        .bold()
                        .font(.title2)
                    
                    Text("""
    All rechargeable batteries are consumable components that become less effective as they chemically age.
    
    As lithium-ion batteries chemically age, the amount of charge they can hold diminishes, resulting in shorter amounts of time before a device needs to be recharged. This can be referred to as the battery’s maximum capacity—the measure of battery capacity relative to when it was new.
    
    In order for a phone to function properly, the electronics must be able to draw upon instantaneous power from the battery. One attribute that affects this instantaneous power delivery is the battery’s impedance.
    
    A battery with a high impedance may be unable to provide sufficient power to the system that needs it. A battery's impedance can increase if a battery has a higher chemical age. A battery’s impedance will temporarily increase at a low state of charge and in a cold temperature environment. When coupled with a higher chemical age, the impedance increase will be more significant.
    
    When power is pulled from a battery with a higher level of impedance, the battery’s voltage will drop to a greater degree. Electronic components require a minimum voltage to properly operate. This includes the device’s internal storage, power circuits, and the battery itself.
    
    The power management system determines the capability of the battery to supply this power, and manages the loads in order to maintain operations. When the operations can no longer be supported with the full capabilities of the power management system, the system will perform a shutdown to preserve these electronic components.
    """)
                    .padding(.bottom, 10)
                }
            }
            .padding(.horizontal, 20)
            
        }
        
    }
    
    // MARK: Functions
    //Hide this view
    func hideView() {
        showThisView = false
    }
}

struct PerformanceArticleView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceArticleView(showThisView: .constant(true))
    }
}
