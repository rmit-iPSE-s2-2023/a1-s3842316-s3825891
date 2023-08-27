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
    var suburbs: [Suburb]
    
    var body: some View {
        
        // Stacks
        NavigationStack {
            VStack(spacing: 20) {
                
                // Title at the top of the view
                TitleView(title: "Watch Zone")
                    .padding(.horizontal, -25)
                    .padding(.bottom, -25)
                Spacer()
                
                // Check if there are any favorite suburbs
                if self.user.favorites.count == 0 {
                    // Display a view with no favorites
                    NoFavoritesView(reports: reports, user: user)
                    
                } else {
                    // Display search bar and list of favorite suburbs
                    SearchBar(data: reports, user: user)
                    
                    List {
                        // Display pinned suburbs if any
                        if user.favorites.first(where: {$0.pinned}) != nil {
                            Section(header: Text("Pinned Suburbs")) {
                                SuburbSubList(reports: self.reports, user: self.user, isPinned: true)
                            }
                        }
                        
                        // Display all other suburbs
                        if user.favorites.first(where: {!$0.pinned}) != nil {
                            Section(header: Text("All Suburbs")) {
                                SuburbSubList(reports: self.reports, user: self.user, isPinned: false)
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
        }
    }
}

// View to be displayed when there are no favorite suburbs
struct NoFavoritesView: View {
    
    var reports: [Report]
    @ObservedObject var user: User
    
    var body: some View {
        
        VStack(spacing: 20.0) {
            
            Spacer()
            
            // Image Binoculars icon
            Image(systemName: "binoculars")
                .resizable()
                .frame(width: 75.0, height: 68)
            
            // Display text
            Text("No Watch Zones")
                .font(.body)
                .fontWeight(.bold)
            Text("Search for any suburb and save it to favorite for future reference")
                .font(.body)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Navigation link to the SearchView
            NavigationLink(destination: SearchView(user: self.user, reports: self.reports)) {
                Label("Add a suburb", systemImage: "magnifyingglass")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(/*@START_MENU_TOKEN@*/.vertical, 12.0/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 30.0)
                    .font(.title3)
                    .frame(width: 375)
            }
            .background(.green)
            .cornerRadius(50)
            Spacer()
                .frame(height: 5)
        }
        .frame(maxWidth: 275)
    }
}

// List item for each suburb
struct SuburbListItem: View {
    
    var suburb: Suburb
    
    var body: some View {

        HStack(alignment: .center) {
            
            // Image map icon
            Image(systemName: "map.fill")
                .foregroundColor(.orange)
                .font(.title)
            
            // Text
            VStack(alignment: .leading) {
                Text(suburb.name)
                    .font(.headline)
                Text("\(suburb.city) - \(String(suburb.postcode))")
                    .foregroundColor(.gray)
                    .font(.body)
            }
        }
    }
}

// A list view to display either pinned or all other suburbs
struct SuburbSubList: View {
    
    var reports: [Report]
    @ObservedObject var user: User
    @State var isPinned: Bool
    
    var body: some View {
        // Determine whether to display pinned or other suburbs
        var subs: [Suburb] {
            if isPinned {
                return user.favorites.filter({$0.pinned})
            } else {
                return user.favorites.filter({!$0.pinned})
            }
        }
        
        // Loop through each suburb and display it
        ForEach(Array(subs.enumerated()), id: \.element) { index, suburb in
            NavigationLink {
                SuburbView(suburb: suburb, reports: reports.filter({$0.suburb.name == suburb.name}), user: self.user, isFavorite: true)
                
            } label: {
                // Each individual suburb list item
                SuburbListItem(suburb: suburb)
                    .swipeActions {
                        // Delete action
                        Button("Delete") {
                            user.removeFavorite(suburb: suburb)
                        }
                        .tint(.red)
                        
                        // Pin or unpin action
                        Button(isPinned ? "Unpin" : "Pin") {
                            user.toggle(suburb: suburb.name)
                        }
                    }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        let user = User.getUser(email: "johndoe@gmail.com")
        FavoriteView(user: user, reports: reportData.data, suburbs: user.favorites)
    }
}
