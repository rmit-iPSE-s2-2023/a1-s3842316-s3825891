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

struct CommonViews_Previews: PreviewProvider {
    static var previews: some View {
        CommonViews()
    }
}

struct TitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 38))
                .fontWeight(.bold)
            Spacer()
        }
        .padding(.top, 40.0)
        .padding(.leading, 25.0)
    }
}

struct SearchBar: View {
    var data: [Report]
    @ObservedObject var user: User
    
    var body: some View {
        NavigationLink(destination: SearchView(user: user, reports: self.data)) {
            HStack() {
                Image(systemName: "magnifyingglass") // Search icon
                    .foregroundColor(.gray)
                Text("Search for suburb")
                    .foregroundColor(.gray)
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

