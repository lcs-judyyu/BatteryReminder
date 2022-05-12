//
//  WebViewModel.swift
//  BatteryLevel
//
//  Created by Judy Yu on 2022-05-12.
//

//Adapted from Culminating Task Code Snippets Project by Russell Gordon
//https://github.com/lcs-judyyu/CulminatingTaskCodeSnippets/tree/main
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
