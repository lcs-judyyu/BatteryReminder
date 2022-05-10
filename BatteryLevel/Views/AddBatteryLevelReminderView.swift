//
//  AddBatteryLevelReminderView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-10.
//

import SwiftUI

struct AddBatteryLevelReminderView: View {
    
    //MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    //list of number options
    let listOfPickerOptions: [Int] = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95]
    
    // Keep track of user selected battery level to receive notification
    @State var selectedBatteryLevel: Int = 30
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Remind me when battery level is at:")
                    .font(.title3)
                
                HStack {
                    Picker("Please choose a number", selection: $selectedBatteryLevel) {
                        
                        ForEach(listOfPickerOptions, id: \.self) {
                            Text("\($0)")
                        }
                        
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Text("%")
                }
                
            }
            .RoundedRectangelOverlay()
            
        }
        
    }
    
    // MARK: Functions
    //Hide this view
    func hideView() {
        showThisView = false
    }
}

struct AddBatteryLevelReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddBatteryLevelReminderView(showThisView: .constant(true),
                                    selectedBatteryLevel: 30)
    }
}
