//
//  SimpleListItemView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-09.
//

//Source: the Composable Views and Animations project by Russell Gordon
//https://github.com/lcs-rgordon/ComposableViewsAndAnimations
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
