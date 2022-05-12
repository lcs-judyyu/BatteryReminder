//
//  WebListItemView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-12.
//

import SwiftUI

struct WebListItemView: View {
    
    // MARK: Stored properties
    let currentArticle: Article
    
    var body: some View {
        
        NavigationLink(destination: {
            
            //navigates to embedded websites
            FullPageWebView(currentArticle: currentArticle)
            
        }, label: {
                
            VStack(alignment: .leading, spacing: 10) {
                
                HStack {
                    Text(currentArticle.title)
                        .foregroundColor(Color("darkOrange"))
                    
                    Spacer()
                }
                
                Divider()
                
            }
            
        })
        
    }
}

struct WebListItemView_Previews: PreviewProvider {
    static var previews: some View {
        WebListItemView(currentArticle: testArticles[1])
    }
}
