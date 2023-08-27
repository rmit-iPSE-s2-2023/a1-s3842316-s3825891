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
        NavigationStack {
            VStack(spacing: 20) {
                TitleView(title: "Watch Zone")
                    .padding(.horizontal, -25)
                    .padding(.bottom, -25)
                Spacer()
                if self.user.favorites.count == 0 {
                    NoFavoritesView(reports: reports, user: user)
                } else {
                    SearchBar(data: reports, user: user)
                    List {
                        if user.favorites.first(where: {$0.pinned}) != nil {
                            Section(header: Text("Pinned Suburbs")) {
                                SuburbSubList(reports: self.reports, user: self.user, isPinned: true)
                            }
                        }
                        
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



struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        let user = User.getUser(email: "johndoe@gmail.com")
        FavoriteView(user: user, reports: reportData.data, suburbs: user.favorites)
    }
}

struct NoFavoritesView: View {
    var reports: [Report]
    @ObservedObject var user: User
    
    var body: some View {
        
        VStack(spacing: 20.0) {
            Spacer()
            Image(systemName: "binoculars")
                .resizable()
                .frame(width: 75.0, height: 68)
            Text("No Watch Zones")
                .font(.body)
                .fontWeight(.bold)
            Text("Search for any suburb and save it to favorite for future reference")
                .font(.body)
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
            Spacer()
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

struct SuburbListItem: View {
    var suburb: Suburb
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "map.fill")
                .foregroundColor(.orange)
                .font(.title)
            
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

struct SuburbSubList: View {
    var reports: [Report]
    @ObservedObject var user: User
    @State var isPinned: Bool
    
    var body: some View {
        var subs: [Suburb] {
            if isPinned {
                return user.favorites.filter({$0.pinned})
            } else {
                return user.favorites.filter({!$0.pinned})
            }
        }
        
        ForEach(Array(subs.enumerated()), id: \.element) { index, suburb in
            NavigationLink {
                SuburbView(suburb: suburb, reports: reports.filter({$0.suburb.name == suburb.name}), user: self.user, isFavorite: true)
                
            } label: {
                SuburbListItem(suburb: suburb)
                    .swipeActions {
                        Button("Delete") {
                            user.removeFavorite(suburb: suburb)
                        }
                        .tint(.red)
                        Button(isPinned ? "Unpin" : "Pin") {
                            user.toggle(suburb: suburb.name)
                        }
                    }
            }
        }
    }
}
