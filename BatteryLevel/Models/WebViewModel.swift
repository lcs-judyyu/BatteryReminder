//
//  WebViewModel.swift
//  BatteryLevel
//

// Adapted from: https://github.com/lcs-rgordon/CulminatingTaskCodeSnippets
import Foundation
import SwiftUI

class WebViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var shouldGoBack: Bool = false
    @Published var title: String = ""
    
    var url: String
    
    init(url: String = "") {
        self.url = url
    }
}
