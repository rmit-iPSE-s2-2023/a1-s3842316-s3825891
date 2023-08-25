//
//  FavoriteView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var user: User
    var reports: [Report]
    
    var body: some View {
        NavigationStack {
            VStack() {
                TitleView(title: "Favorites")
                Spacer()
                if self.user.favorites.count == 0 {
                    NoFavoritesView(reports: reports, user: user)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        FavoriteView(user: User.getUser(email: "johndoe2@gmail.com"), reports: reportData.data)
    }
}

struct NoFavoritesView: View {
    var reports: [Report]
    var user: User
    
    var body: some View {
        
        VStack(spacing: 20.0) {
            Image(systemName: "map")
                .resizable()
                .frame(width: 75.0, height: 68)
            Text("No Saved Favorites")
                .font(.body)
                .fontWeight(.bold)
            Text("Search for any suburb and save it to favorite for future reference")
                .font(.body)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
            NavigationLink(destination: SearchView(user: self.user, reports: self.reports)) {
                Label("Find a Suburb", systemImage: "magnifyingglass")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 12.0/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 30.0)
                    .font(.title3)
                
            }
            .background(.green)
            .cornerRadius(50)
            
            
        }
        .frame(maxWidth: 275)
    }
}

func searchButtton() {
    
}
