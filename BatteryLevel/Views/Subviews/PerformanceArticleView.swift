//
//  PerformanceArticleView.swift
//  BatteryLevel
//

import SwiftUI

// Source: https://support.apple.com/en-us/HT208387
struct PerformanceArticleView: View {
    
    // MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                VStack {
                    
                    Image("Performance")
                        .resizable()
                        .scaledToFit()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Group {
                            
                            Text("About lithium-ion batteries")
                                .bold()
                                .font(.title2)
                            
                            Text("""
            Most phone batteries today use lithium-ion technology.
            
            Compared with older generations of battery technology, lithium-ion batteries charge faster, last longer, and have a higher power density for more battery life in a lighter package.
            """)
                            
                            Image("Charge")
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Group {
                            
                            Text("When batteries chemically age")
                                .bold()
                                .font(.title2)
                            
                            Text("""
            All rechargeable batteries are consumable components that become less effective as they chemically age.
            
            As lithium-ion batteries chemically age, the amount of charge they can hold diminishes, resulting in shorter amounts of time before a device needs to be recharged. This can be referred to as the battery’s maximum capacity—the measure of battery capacity relative to when it was new.
            """)
                            
                            Image("BatteryCharging")
                                .resizable()
                                .scaledToFit()
                            
                            Text("""
            In order for a phone to function properly, the electronics must be able to draw upon instantaneous power from the battery.
            
            One attribute that affects this instantaneous power delivery is the battery’s impedance.
            
            When power is pulled from a battery with a higher level of impedance, the battery’s voltage will drop to a greater degree. Electronic components require a minimum voltage to properly operate.
            """)
                        }
                    }
                    .padding([.horizontal, .bottom], 18)
                    
                }
                
            }
            .navigationTitle("Battery Performance")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        hideView()
                    }
                    .tint(Color("teal"))
                }
            }
        }
    }
    
    // MARK: Functions
    // Hide this view
    func hideView() {
        
        showThisView = false
        
    }
}

struct PerformanceArticleView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceArticleView(showThisView: .constant(true))
    }
}
