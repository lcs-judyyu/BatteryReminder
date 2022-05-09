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
            
            VStack (alignment: .center, spacing: 20){
                
                Button {
                    
                    showPerformanceArticle = true
                    
                } label: {
                    
                    ArticlesCardView(imageName: "Performance",
                                     title: "Battery and Performance",
                                     description: "How does your battery work?")
                    
                }
                .sheet(isPresented: $showPerformanceArticle) {
                    PerformanceArticleView(showThisView: $showPerformanceArticle)
                }
                
                Button {
                    
                    showTipsArticle = true
                    
                } label: {
                    
                    ArticlesCardView(imageName: "Tips",
                                     title: "General Performance Tips",
                                     description: "How to improve your battery performance?")
                    
                }
                .sheet(isPresented: $showTipsArticle) {
                    TipsArticleView(showThisView: $showTipsArticle)
                }
                

            }
            .padding()

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
