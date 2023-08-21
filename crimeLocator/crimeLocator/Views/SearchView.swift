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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.reports) { report in
                    SuburbListView(suburb: report.suburb)
                }
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

