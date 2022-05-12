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
    
    // List of articles that will be loaded from the Sheety endpoint in JSON format
    @State var articlesToShow: [Article] = []
    
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
                    
                    Group {
                        
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
                        
                    }
                    
                    //External Articles
                    Group {
                    
                    Text("External Articles")
                        .bold()
                        .font(.title2)
                    
                    ZStack {
                        
                        // Shows list of articles, when there are some to show
                        ForEach(articlesToShow, id: \.self) { currentArticle in
                            
                            NavigationLink(destination: {
                                
                                //navigates to embedded websites
                                
                            }, label: {
                                
                                Text(currentArticle.title)
                                    .font(.headline)
                                
                            })
                            
                        }
                        
                        // Show a message when there are no results yet
                        HStack {
                            
                            Text("Loading...")
                            
                            Spacer()
                        }
                        .RoundedRectangelOverlay()
                        .opacity(articlesToShow.isEmpty ? 1.0 : 0.0)

                    }
                        
                    }
                    
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
    func fetchResults() async {
        
        // Set the address of the JSON endpoint
        let url = URL(string: Articles.endpoint)!
        
        // Configure a URLRequest instance
        // Defines what type of request will be sent to the address noted above
        var request = URLRequest(url: url)
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"  // Getting data from the web server...
        
        // Start a URL session to interact with the endpoint
        let urlSession = URLSession.shared
        
        // Fetch the results of this search
        do {
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // DEBUG: See what raw JSON data was returned from the server
            print(String(data: data, encoding: .utf8)!)
            
            // Attempt to decode and return the object all the rows of the spreadsheet
            // NOTE: We decode to Announcements.self since the endpoint
            //       returns a single JSON object
            let decodedArticles = try JSONDecoder().decode(Articles.self, from: data)
            
            // Now, we access the rows of the spreadsheet
            articlesToShow = decodedArticles.list
            
        } catch {
            
            // Report about what happened
            print("Could not retrieve / decode JSON from endpoint.")
            print(error)
            
        }
        
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView(articlesToShow: testArticles)
        }
    }
}
