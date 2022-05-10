//
//  SimpleListItemView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-09.
//

//Adapted from the Composable Views and Animations project by Russell Gordon
//https://github.com/lcs-rgordon/ComposableViewsAndAnimations
import SwiftUI

struct SimpleListItemView: View {
    
    //Stored properties
    var title: String
    var description: String
    
    @State var pushNotification: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            
            Toggle(title, isOn: $pushNotification)
                .font(.title2)
                .toggleStyle(SwitchToggleStyle(tint: Color("darkOrange")))
            
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
