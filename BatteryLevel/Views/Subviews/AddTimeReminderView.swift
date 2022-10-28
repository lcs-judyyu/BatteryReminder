//
//  AddTimeReminderView.swift
//  BatteryLevel
//

import SwiftUI

struct AddTimeReminderView: View {
    
    //MARK: Stored properties
    // Controls whether this view is showing or not
    @Binding var showThisView: Bool
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                //Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("This feature is not supported currently. Please check again later :)")
                    
                }
                
            }
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        hideView()
                    }
                }
            }
            
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
