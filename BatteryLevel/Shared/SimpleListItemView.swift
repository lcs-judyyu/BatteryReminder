//
//  SimpleListItemView.swift
//  BatteryLevel
//

import SwiftUI

struct SimpleListItemView: View {
    
    // MARK: Stored properties
    var title: String
    var repeated: Bool
    @State var pushNotification: Bool
    
    // MARK: Computed properties
    var description: String {
        
        if repeated == true {
            return "Repeated"
        } else {
            return "Not Repeated"
        }
        
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            
            Toggle("\(title)%", isOn: $pushNotification)
                .font(.title)
                .toggleStyle(SwitchToggleStyle(tint: Color("goldDrop")))
                .disabled(true)
            
            Text(description)
                .font(.caption2)
            
        }
    }
}

struct SimpleListItemView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleListItemView(title: "30",
                           repeated: true,
                           pushNotification: true)
    }
}
