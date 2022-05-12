//
//  WebView.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-12.
//

//Adapted from Culminating Task Code Snippets Project by Russell Gordon
//https://github.com/lcs-judyyu/CulminatingTaskCodeSnippets/tree/main
import SwiftUI

struct WebView: View {
    
    // MARK: Stored properties
    @ObservedObject var webViewModel: WebViewModel
    
    // Should navigation be restricted to a given page or site?
    @State var restrictToAddressBeginningWith: String
    
    // MARK: Computed properties
    var body: some View {
        
        VStack(alignment: .center) {
            
            ZStack {

                // If navigation has occured, and there is a page to go back to, allow this via a button
                Button(action: {
                    
                    webViewModel.shouldGoBack.toggle()
                    
                }, label: {
                    
                    if webViewModel.canGoBack {

                        HStack {

                            Image(systemName: "arrow.backward.circle")
                                .frame(width: 22, height: 22, alignment: .center)
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                                .padding(.top, 10)

                            Spacer()

                        }
                                                
                    } else {
                        EmptyView()
                            .frame(width: 0, height: 0, alignment: .center)
                    }
                    
                })
                
                Text(webViewModel.title)
                    .font(.caption2)
                    .bold()
                    .padding(.horizontal, 42)
                    .padding(.top, 10)
                    .multilineTextAlignment(.center)
                

            }
            
            ZStack {
                
                WebViewContainer(webViewModel: webViewModel, restrictToAddressBeginningWith: restrictToAddressBeginningWith)
                
                // When the web page is loading, overlay a waiting indicator.
                if webViewModel.isLoading {
                    ProgressView()
                }
                
            }

        }
        
    }
    
    // MARK: Initializer
    init(address: String, restrictToAddressBeginningWith: String = "") {
        webViewModel = WebViewModel(url: address)
        self.restrictToAddressBeginningWith = restrictToAddressBeginningWith
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(address: "https://www.russellgordon.ca")
    }
}

