//
//  ReportView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

//Adapted from : https://swiftwombat.com/how-to-store-a-date-using-appstorage-in-swiftui/
//format a date to String and map it back
extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }
}

struct ReportView: View {
    
    // MARK: Stored properties
    //Detect when app moves between foreground, background, and inactive atates
    @Environment(\.scenePhase) var scenePhase
    
    // Controls what article is showing in the pop-up sheet
    @State private var showPerformanceArticle = false
    @State private var showTipsArticle = false
    
    //Store last time fully charged
    @AppStorage("lastTimeFullyCharged") var lastTimeFullyCharged: Date = Date()
    
    //var timeHistory = "--"
    
    //current battery state
    @State private var batteryState = UIDevice.BatteryState.unknown
    
    var body: some View {
        
        ScrollView {
            
            ZStack {
                
                //Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 20){
                    
                    Group {
                        
                        Text("Last time charged to 100%:")
                            .bold()
                            .font(.title2)
                        
                        HStack {
                            
                            //time first
                            Text(lastTimeFullyCharged.formatted(date: .omitted, time: .standard))
                            
                            //then date
                            Text(lastTimeFullyCharged.formatted(date: .abbreviated, time: .omitted))
                            
                            Spacer()
                            
                        }
                        .font(.title3)
                        .RoundedRectangelOverlay()
                        .onBatteryStateChanged { newState in
                            batteryState = newState
                            print("Battery state is \(batteryState)")
                            
                            if batteryState == .full {
                                lastTimeFullyCharged = Date.now
                                print(lastTimeFullyCharged)
                            }
                            
                        }
                        
                    }
                    
                    Text("about batteries".capitalized(with: .current))
                        .bold()
                        .font(.title2)
                    
                    // Pop-up sheet is adapted from the Composable Views and Animations project by Russell Gordon
                    //https://github.com/lcs-rgordon/ComposableViewsAndAnimations
                    Button {
                        
                        showPerformanceArticle = true
                        
                    } label: {
                        
                        ArticlesCardView(imageName: "Performance",
                                         title: "Battery and Performance",
                                         description: "All about your battery")
                        
                    }
                    .sheet(isPresented: $showPerformanceArticle) {
                        PerformanceArticleView(showThisView: $showPerformanceArticle)
                    }
                    
                    Button {
                        
                        showTipsArticle = true
                        
                    } label: {
                        
                        ArticlesCardView(imageName: "Tips",
                                         title: "General Performance Tips",
                                         description: "Improving your battery performance")
                        
                    }
                    .sheet(isPresented: $showTipsArticle) {
                        TipsArticleView(showThisView: $showTipsArticle)
                    }
                    
                    Text("External Articles")
                        .bold()
                        .font(.title2)
                    
                    HStack {
                        
                        Text("a list item that navigates to an embedded website")
                        
                        Spacer()
                        
                    }
                    .RoundedRectangelOverlay()
                    
                }
                .padding(20)
                
            }
            
            
        }
        .navigationTitle("Report")
        // Make the nav bar be "small" at top of view
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active{
                print("Active")
            } else {
                print("Background")
                
                //save the time
                print(lastTimeFullyCharged)
            }
        }
        .task {
            //load the time
            print(lastTimeFullyCharged)
        }
    }
    
    // MARK: Functions
    
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView()
        }
    }
}
