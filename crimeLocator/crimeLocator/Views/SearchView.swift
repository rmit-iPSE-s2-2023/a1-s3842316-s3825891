//
//  SearchView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 21/8/2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    
    var user: User
    var reports: [Report]
    var filteredReports: [Report] {
        var res: [Report] = self.reports
        if !searchText.isEmpty {
            res = self.reports.filter({$0.suburb.name.contains(searchText)})
        }
        return res.sorted {
            $0.suburb.name < $1.suburb.name
        }
    }
    
    var uniqueSuburbReports: [Report] {
        var suburbs = [String]()
        var res = [Report]()
        for report in self.filteredReports {
            if !suburbs.contains(report.suburb.name) {
                res.append(report)
                suburbs.append(report.suburb.name)
            }
        }
        return res
    }
    
    var body: some View {
        NavigationView {
            if self.filteredReports.count > 0 {
                List {
                    ForEach(self.uniqueSuburbReports) { report in
                        SuburbListView(suburb: report.suburb, reports: self.filteredReports, user: self.user)
                    }
                }
            } else {
                Text("'\(searchText)' suburb not found!")
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Suburbs")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var reportData = DataLoader<Report>(resource: "ReportData")
        @ObservedObject var userData = DataLoader<User>(resource: "UserData")
        SearchView(user: userData.data[1], reports: reportData.data)
    }
}

// List Items View
struct SuburbListView: View {
    var suburb: Suburb
    var reports: [Report]
    var user: User
    
    var body: some View {
        NavigationLink(destination: SuburbView(suburb: suburb, reports: reports, user: self.user, isFavorite: user.favorites.contains(suburb))) { // Destination page
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(self.suburb.name)
                }
            }
        }
    }
}

