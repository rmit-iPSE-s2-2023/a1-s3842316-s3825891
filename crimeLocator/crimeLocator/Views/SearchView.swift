//
//  SearchView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 21/8/2023.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    
    var reports: [Report]
    var filteredReports: [Report] {
        var res: [Report] = self.reports
        if !searchText.isEmpty {
            res = self.reports.filter({$0.suburb.contains(searchText)})
        }
        return res.sorted {
            $0.suburb < $1.suburb
        }
    }
    
    var body: some View {
        NavigationView {
            if filteredReports.count > 0 {
                List {
                    ForEach(filteredReports) { report in
                        SuburbListView(suburb: report.suburb)
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
        SearchView(reports: reportData.data)
    }
}

// List Items View
struct SuburbListView: View {
    var suburb: String
    
    var body: some View {
        NavigationLink(destination: SuburbView()) { // Destination page
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(self.suburb)
                }
            }
        }
    }
}

