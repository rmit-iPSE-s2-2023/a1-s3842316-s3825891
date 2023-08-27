//
//  SearchView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 21/8/2023.
//

import SwiftUI

struct SearchView: View {
    // Search text binding
    @State var searchText = ""
    
    @ObservedObject var user: User
    
    var reports: [Report]
    
    // Computed property to filter and sort reports based on search text
    var filteredReports: [Report] {
        var res: [Report] = self.reports
        if !searchText.isEmpty {
            res = self.reports.filter({$0.suburb.name.contains(searchText)})
        }
        return res.sorted {
            $0.suburb.name < $1.suburb.name
        }
    }
    
    // Computed property to get unique suburbs from the filtered reports
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
                        SuburbListView(user: user, suburb: report.suburb, reports: self.filteredReports)
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

// List Items View (Single row representing a suburb)
struct SuburbListView: View {
    
    @ObservedObject var user: User
    var suburb: Suburb
    var reports: [Report]
    
    var body: some View {
        
        NavigationLink(destination: SuburbView(suburb: suburb, reports: reports.filter({$0.suburb.name == suburb.name}), user: self.user, isFavorite: user.favorites.filter({$0.id == suburb.id}).count > 0)) {
            
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        
                        // Text (Suburb Name)
                        Text(self.suburb.name)
                            .font(.title3)
                    }
                    Text("\(self.reports.filter({$0.suburb.name == suburb.name}).count) new reports")
                        .font(.caption)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        SearchView(user: User.getUser(email: "johndoe@gmail.com"), reports: reportData.data)
    }
}
