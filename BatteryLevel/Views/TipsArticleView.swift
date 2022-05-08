//
//  TipsArticleView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

//Source: https://www.apple.com/ca/batteries/maximizing-performance/

struct TipsArticleView: View {
    
    //MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .center) {
                Text("General Performance Tips".capitalized(with: .current))
                    .bold()
                    .italic()
                    .font(.title2)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                
                Group {
                    
                    Text("Avoid extreme ambient temperatures.")
                        .bold()
                        .font(.title2)
                    
                    Text("""
    Your device is designed to perform well in a wide range of ambient temperatures, with 62° to 72° F (16° to 22° C) as the ideal comfort zone. It’s especially important to avoid exposing your device to ambient temperatures higher than 95° F (35° C), which can permanently damage battery capacity. That is, your battery won’t power your device as long on a given charge.
    
    Charging the device in high ambient temperatures can damage it further. Software may limit charging above 80% when the recommended battery temperatures are exceeded. When using your device in a very cold environment, you may notice a decrease in battery life, but this condition is temporary. Once the battery’s temperature returns to its normal operating range, its performance will return to normal as well.
    """)
                    
                    Image("ExtremeTemperatures")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 20)
                }
                
                Group {
                    
                    Text("Remove certain cases during charging.")
                        .bold()
                        .font(.title2)
                    
                    Text("""
    Charging your device when it’s inside certain styles of cases may generate excess heat, which can affect battery capacity. If you notice that your device gets hot when you charge it, take it out of its case first.
    """)
                    
                }
                
                Group {
                    Text("Store it half-charged when you store it long term")
                        .bold()
                        .font(.title2)
                    Text("""
    If you want to store your device long term, two key factors will affect the overall health of your battery: the environmental temperature and the percentage of charge on the battery when it’s powered down for storage. Therefore, here are some tips:
    """)
                    .padding(.bottom, 10)
                    
                    Label(title: {
                        Text("""
        Do not fully charge or fully discharge your device’s battery — charge it to around 50%. If you store a device when its battery is fully discharged, the battery could fall into a deep discharge state, which renders it incapable of holding a charge. Conversely, if you store it fully charged for an extended period of time, the battery may lose some capacity, leading to shorter battery life.
        """)
                    }, icon: {
                        Image(systemName: "battery.50")
                    })
                    
                    Label(title: {
                        Text("Power down the device to avoid additional battery use.")
                    }, icon: {
                        Image(systemName: "power.circle")
                    })
                    
                    Label(title: {
                        Text("Place your device in a cool, moisture-free environment that’s less than 90° F (32° C).")
                    }, icon: {
                        Image(systemName: "thermometer")
                    })
                    
                    Label(title: {
                        Text("If you plan to store your device for longer than six months, charge it to 50% every six months.")
                    }, icon: {
                        Image(systemName: "6.alt.circle")
                    })
                    
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

struct TipsArticleView_Previews: PreviewProvider {
    static var previews: some View {
        TipsArticleView(showThisView: .constant(true))
    }
}
