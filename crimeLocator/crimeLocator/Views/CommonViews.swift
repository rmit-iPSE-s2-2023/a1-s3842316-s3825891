//
//  CommonViews.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 18/8/2023.
//

import SwiftUI

struct CommonViews: View {
    var body: some View {
        TitleView(title: "Title View")
    }
}

// TitleView struct to display a title text
struct TitleView: View {
    
    var title: String
    
    var body: some View {
        
        
        HStack {
            // Text
            Text(title)
                .font(.system(size: 38))
                .fontWeight(.bold)
            // Push the text to the leading edge
            Spacer()
        }
        .padding(.top, 40.0)
        .padding(.leading, 25.0)
    }
}

// SearchBar struct to display a search bar
struct SearchBar: View {
    
    var data: [Report]
    @ObservedObject var user: User
    
    var body: some View {
        
        // Navigation link to the SearchView
        NavigationLink(destination: SearchView(user: user, reports: self.data)) {
            
            HStack() {
                
                // Magnifying glass icon
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                // Placeholder text for the search bar
                Text("Search for suburb")
                    .foregroundColor(.gray)
                
                // Push the content to the leading edge
                Spacer()
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray5))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        CommonViews()
    }
}

