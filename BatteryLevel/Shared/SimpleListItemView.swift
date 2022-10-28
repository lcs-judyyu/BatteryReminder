//
//  SimpleListItemView.swift
//  BatteryLevel
//

import SwiftUI

struct SimpleListItemView: View {
    
    //Stored properties
    var title: String
    var description: String
    
    @State var pushNotification: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 3) {
            
            Toggle(title, isOn: $pushNotification)
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
        SimpleListItemView(title: "Some title",
                           description: "repeated",
                           pushNotification: true)
    }
}
