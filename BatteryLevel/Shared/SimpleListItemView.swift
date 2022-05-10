//
//  SimpleListItemView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-09.
//

//Adapted from the Composable Views and Animations project by Russell Gordon
import SwiftUI

struct SimpleListItemView: View {
    
    //Stored properties
    var title: String
    var description: String
    
    @State var pushNotification: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Toggle(title, isOn: $pushNotification)
                .toggleStyle(SwitchToggleStyle(tint: Color("darkOrange")))
            
            Text(description)
                .font(.caption)
            
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
