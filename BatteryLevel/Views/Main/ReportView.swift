//
//  ReportView.swift
//  BatteryLevel
//

import SwiftUI

struct ReportView: View {
    
    // MARK: Stored properties
    
    // Controls what article is showing in the pop-up sheet
    @State private var showPerformanceArticle = false
    @State private var showTipsArticle = false
    
    // List of articles that will be loaded from the Sheety endpoint in JSON format
    @State var articlesToShow: [Article] = []
    
    var body: some View {
        
        ScrollView {
            
            ZStack {
                
                // Background color
                Color("backgroundGray")
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .leading, spacing: 20){
                    
                    Group {
                        
                        Text("About Batteries")
                            .bold()
                            .font(.title2)
                        
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
                    
                    // External Articles
                    Group {
                        
                        Text("External Articles")
                            .bold()
                            .font(.title2)
                        
                        ZStack {
                            
                            VStack (alignment: .leading) {
                                // Shows list of articles, when there are some to show
                                ForEach(articlesToShow, id: \.self) { currentArticle in
                                    
                                    WebListItemView(currentArticle: currentArticle)
                                    
                                    if currentArticle.id - 1 != articlesToShow.count {
                                        Divider()
                                    }
                                    
                                }
                            }
                            .RoundedRectangelOverlay()
                            
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
        .navigationTitle("More Information")
        // Make the nav bar be inlined at top of view
        .navigationBarTitleDisplayMode(.inline)
        .task {
            
            //load the list of external articles
            await fetchResults()
            
        }
    }
    
    // MARK: Functions
    // Adapted from the Concept Review project by Russell Gordon
    func fetchResults() async {
        
        // Set the address of the JSON endpoint
        let url = URL(string: Articles.endpoint)!
        
        // Configure a URLRequest instance
        // Defines what type of request will be sent to the address noted above
        var request = URLRequest(url: url)
        request.setValue("application/json",
                         forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"  // Getting data from the web server
        
        // Start a URL session to interact with the endpoint
        let urlSession = URLSession.shared
        
        // Fetch the results of this search
        do {
            // Get the raw data from the endpoint
            let (data, _) = try await urlSession.data(for: request)
            
            // DEBUG: See what raw JSON data was returned from the server
            print(String(data: data, encoding: .utf8)!)
            
            // Attempt to decode and return the object all the rows of the spreadsheet
            // NOTE: decode to Articles.self since the endpoint returns a single JSON object
            let decodedArticles = try JSONDecoder().decode(Articles.self, from: data)
            
            // Access the rows of the spreadsheet
            articlesToShow = decodedArticles.sheet1
            
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
