//
//  FullPageWebView.swift
//  BatteryLevel
//

import SwiftUI

struct FullPageWebView: View {
    
    // MARK: Stored properties
    let currentArticle: Article
    
    var body: some View {
        
        // This will take up the full screen
        // Navigation is not restricted
        WebView(address: currentArticle.url,
                restrictToAddressBeginningWith: "")
        
    }
}

struct FullPageWebView_Previews: PreviewProvider {
    static var previews: some View {
        FullPageWebView(currentArticle: testArticles[1])
    }
}
