//
//  AddTimeReminderView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-10.
//

import SwiftUI

struct AddTimeReminderView: View {
    
    //MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    var body: some View {
        
        NavigationView {
            
        }
        
    }
    
    // MARK: Functions
    //Hide this view
    func hideView() {
        showThisView = false
    }
}

struct AddTimeReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddTimeReminderView(showThisView: .constant(true))
    }
}
