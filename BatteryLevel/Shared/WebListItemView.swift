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
                
            VStack(alignment: .leading, spacing: 12) {
                
                HStack {
                    Text(currentArticle.title)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .scaleEffect(0.7)
                        .foregroundColor(.gray)
                        .opacity(0.6)
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
