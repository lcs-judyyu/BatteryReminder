//
//  ReportView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-08.
//

import SwiftUI

struct ReportView: View {
    
    // MARK: Stored properties
    
    // Controls what article is showing in the pop-up sheet
    @State private var showPerformanceArticle = false
    @State private var showTipsArticle = false
    
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
                            .italic()
                            .font(.title2)
                        
                        HStack {
                            
                            Text("last time from the history list")
                                .font(.title3)
                            
                            Spacer()
                            
                        }
                        .RoundedRectangelOverlay()
                        
                    }
                    
                    Text("about batteries".capitalized(with: .current))
                        .bold()
                        .font(.title2)
                    
                    // Pop-up sheet is adapted from the Composable Views and Animations project by Russell Gordon
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
                    
                    Text("External Links")
                        .bold()
                        .font(.title2)
                    
                    Group {
                        
                        Text("a list item that navigates to an embedded website")
                        
                    }
                    .RoundedRectangelOverlay()                    
                    
                }
                .padding(20)
                
            }
            
        }
        .navigationTitle("Reports")
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReportView()
        }
    }
}
