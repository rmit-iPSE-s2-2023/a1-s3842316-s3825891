//
//  ContentView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 7/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    var user = User.getUser(email: "johndoe2@gmail.com")
    
    var reportData = DataLoader<Report>(resource: "ReportData")
    
    var body: some View {
        
        let tabs = [
            TabItem(image: "doc.text.image", title: "Today", view: AnyView(HomeView(user: user, reports: reportData.data))),
            TabItem(image: "bookmark.circle", title: "Favorites", view: AnyView(FavoriteView(suburbs: user.favorites, reports: reportData.data, user: user))),
            TabItem(image: "clock.arrow.circlepath", title: "Recent", view: AnyView(RecentView())),
            TabItem(image: "gearshape", title: "Settings", view: AnyView(SettingView())),
        ]
        
        TabView(selection: .constant(1)) {
            Group {
                ForEach(tabs) { tab in
                    tab.view
                        .tabItem {
                            Image(systemName: tab.image)
                            Text(tab.title)
                        }
                        .tag(tab.id)
                        .environmentObject(user)
                }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

struct TabItem: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var view: AnyView
    
    init(image: String, title: String, view: AnyView) {
        self.image = image
        self.title = title
        self.view = view
    }
}
