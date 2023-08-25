//
//  ContentView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 7/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var userData = DataLoader<User>(resource: "UserData")
    @ObservedObject var reportData = DataLoader<Report>(resource: "ReportData")
    
    
    var body: some View {
        
        var tabs = [
            TabItem(image: "doc.text.image", title: "Today", view: AnyView(HomeView(user: userData.data[1], reports: reportData.data))),
            TabItem(image: "bookmark.circle", title: "Favorites", view: AnyView(FavoriteView())),
            TabItem(image: "clock.arrow.circlepath", title: "Recent", view: AnyView(RecentView())),
            TabItem(image: "gearshape", title: "Settings", view: AnyView(SettingView())),
        ]
        
        TabView(selection: .constant(1)) {
            ForEach(tabs) { tab in
                tab.view
                    .tabItem {
                        Image(systemName: tab.image)
                        Text(tab.title)
                    }
                    .tag(tab.id)
                    .background(.black.opacity(0.0))
            }
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
