//
//  ArticlesCardView.swift
//  BatteryLevel
//

import SwiftUI

struct ArticlesCardView: View {
    
    //MARK: Stored properties
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading){
            
            Image(imageName)
                .resizable()
                .scaledToFit()
            
            Group {
                Text(title)
                    .bold()
                    .foregroundColor(Color.black)
                    .font(.title2)
                
                Text(description)
                    .foregroundColor(Color.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
            }
            .padding(.leading, 15)
            
        }
        .padding(.bottom, 15)
        .background(Color.white)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
    }
}

struct ArticlesCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesCardView(imageName: "Performance",
                         title: "Battery and Performance",
                         description: "How does your battery work?")
    }
}
