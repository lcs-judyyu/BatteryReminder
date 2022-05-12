//
//  WebViewContainer.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-12.
//

//Adapted from Culminating Task Code Snippets Project by Russell Gordon
//https://github.com/lcs-judyyu/CulminatingTaskCodeSnippets/tree/main
import Foundation
import WebKit
import SwiftUI

struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var webViewModel: WebViewModel
    let restrictToAddressBeginningWith: String
    
    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, webViewModel, restrictToAddressBeginningWith)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.webViewModel.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if webViewModel.shouldGoBack {
            uiView.goBack()
            webViewModel.shouldGoBack = false
        }
    }
}

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var webViewModel: WebViewModel
        private let parent: WebViewContainer
        private let restrictToAddressBeginningWith: String
        
        init(_ parent: WebViewContainer, _ webViewModel: WebViewModel, _ restrictToAddressBeginningWith: String) {
            self.parent = parent
            self.webViewModel = webViewModel
            self.restrictToAddressBeginningWith = restrictToAddressBeginningWith
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            webViewModel.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewModel.isLoading = false
            webViewModel.title = webView.title ?? ""
            webViewModel.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            webViewModel.isLoading = false
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let host = navigationAction.request.url?.host {
                print("--\nabout to check restriction, navigation is restricted to sites starting with: \(restrictToAddressBeginningWith)")
                print("navigating to: \(host.description)")
                if host.starts(with: restrictToAddressBeginningWith) {
                    decisionHandler(.allow)
                    print("navigation allowed")
                    return
                }
            }
            
            print("navigation cancelled")
            decisionHandler(.cancel)
        }
    }
}

