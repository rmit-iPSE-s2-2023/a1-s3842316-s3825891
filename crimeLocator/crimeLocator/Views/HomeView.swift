//
//  HomeView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var users = DataLoader<User>(resource: "UserData")
    @ObservedObject var reports = DataLoader<Report>(resource: "ReportData")
    
    var body: some View {
        Text("Home View")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
