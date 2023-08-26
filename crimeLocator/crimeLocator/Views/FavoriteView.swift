//
//  FavoriteView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var user: User
    @ObservedObject var favoriteSuburbs: SuburbList
    var reports: [Report]
    var suburbs: [Suburb]
    
    init(suburbs: [Suburb], reports: [Report], user: User) {
        self.suburbs = suburbs
        self.reports = reports
        self.user = user
        self.favoriteSuburbs = SuburbList(pinnedSuburbs: self.suburbs.filter({$0.pinned}), unPinnedSuburbs: self.suburbs.filter({!$0.pinned}))
    }
    
    var body: some View {
        NavigationStack {
            VStack() {
                TitleView(title: "Favorites")
                Text("\(user.favorites.count) - \(favoriteSuburbs.pinnedSuburbs.count) - \(favoriteSuburbs.unPinnedSuburbs.count)")
                Spacer()
                if self.user.favorites.count == 0 {
                    NoFavoritesView(reports: reports, user: user)
                } else {
//                    SearchBar(data: reports, user: user)
                    List {
                        Section(header: Text("Pinned Suburbs")) {
                            SuburbSubList(reports: self.reports, user: self.user, isPinned: true)
                                .environmentObject(favoriteSuburbs)
                            
                        }
                        
                        Section(header: Text("All Suburbs")) {
                            SuburbSubList(reports: self.reports, user: self.user, isPinned: false)
                                .environmentObject(favoriteSuburbs)
                            
                        }
                        
                    }
                    
                    
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
//            self.favoriteSuburbs = SuburbList(pinnedSuburbs: self.suburbs.filter({$0.pinned}), unPinnedSuburbs: self.suburbs.filter({!$0.pinned}))
        }
    }
}



struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        let user = User.getUser(email: "johndoe2@gmail.com")
        FavoriteView(suburbs: user.favorites, reports: reportData.data, user: User.getUser(email: "johndoe2@gmail.com"))
    }
}

struct NoFavoritesView: View {
    var reports: [Report]
    @ObservedObject var user: User
    
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
    @EnvironmentObject var favoriteList: SuburbList
    @State var isPinned: Bool
    
    init(reports: [Report], user: User, isPinned: Bool) {
        self.isPinned = isPinned
        self.reports = reports
        self.user = user
    }
    
    var body: some View {
//        var list: [Suburb] {
//            if isPinned {
//                return user.favorites.filter({$0.pinned})
//            } else {
//                retunr user.favorites.filter({!$0.pinned})
//            }
//        }
        Text("\(user.favorites.count) - \(favoriteList.pinnedSuburbs.count) - \(favoriteList.unPinnedSuburbs.count)")
        ForEach(Array(isPinned ? favoriteList.pinnedSuburbs.enumerated() : favoriteList.unPinnedSuburbs.enumerated()), id: \.element) { index, suburb in
            NavigationLink {
                SuburbView(suburb: suburb, reports: reports, user: self.user, isFavorite: true)
                
            } label: {
                SuburbListItem(suburb: suburb)
                    .swipeActions {
                        Button("Delete") {
                            user.removeFavorite(suburb: suburb)
                            self.isPinned ? favoriteList.removePinnedSuburb(suburb: suburb) : favoriteList.removeUnPinnedSuburb(suburb: suburb)
                            user.favorites = favoriteList.pinnedSuburbs + favoriteList.unPinnedSuburbs
                        }
                        .tint(.red)
                        Button(isPinned ? "Unpin" : "Pin") {
                            var s = isPinned ? favoriteList.pinnedSuburbs[index] : favoriteList.unPinnedSuburbs[index]
                            s.pinned ? favoriteList.unPin(suburb: &s) : favoriteList.pin(suburb: &s)
                            user.favorites = favoriteList.pinnedSuburbs + favoriteList.unPinnedSuburbs
                        }
                    }
            }
        }
    }
}
