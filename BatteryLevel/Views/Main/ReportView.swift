//
//  ReportView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

struct ReportView: View {
    
    // MARK: Stored properties
    //Detect when app moves between foreground, background, and inactive atates
    @Environment(\.scenePhase) var scenePhase
    
    // Controls what article is showing in the pop-up sheet
    @State private var showPerformanceArticle = false
    @State private var showTipsArticle = false
    
    //Store last time fully charged
    @State private var lastTimeFullyCharged = Date()
    
    var timeHistory = "--"
    
    // keep track of the time history
    @State var favourites: [Time] = []   // empty list to start
    
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
                            
                            //date
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
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive {
                print("Inactive")
            } else if newPhase == .active{
                print("Active")
            } else {
                print("Background")
                
                //permanently save the time
                persistTime()
            }
        }
    }
    
    // MARK: Functions
    //save data permanently
    func persistTime() {
        //get a location to save data
        let filename = getDocumentsDirectory().appendingPathComponent(savedTimeHistoryLabel)
        print(filename)
        
        //try to encodr data to JSON
        do {
            let encoder = JSONEncoder()
            
            //configure the encoder to "pretty print" the JSON
            encoder.outputFormatting = .prettyPrinted
            
            //Encode the list of favourites
            let data = try encoder.encode(lastTimeFullyCharged)
            
            //write JSON to a file in the filename location
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            //see the data
            print("Save data to the document directory successfully.")
            print("=========")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            print("Unable to write list of favourites to the document directory")
            print("=========")
            print(error.localizedDescription)
        }
    }
    
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView()
        }
    }
}
