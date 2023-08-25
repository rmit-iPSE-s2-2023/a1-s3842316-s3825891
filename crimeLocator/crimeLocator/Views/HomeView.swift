//
//  HomeView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    // Map center - QLD
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
    )
    
    // Data Loader
    @ObservedObject var reportData = DataLoader<Report>(resource: "ReportData")
    @ObservedObject var userData = DataLoader<User>(resource: "UserData")
    
    @State var listActive = false
    
    
    var body: some View {
        NavigationStack {
        
            VStack(alignment: .leading, spacing: 20.0) {
                Text("Welcome \(userData.data[1].fullName)!")
                    .font(.title)
                    .padding(.top, 10.0)
                SearchBar(data: reportData.data, user: self.userData.data[1])
                Map(coordinateRegion: $region)
                    .frame(height: 380)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -5)
                
                
                ListView(data: reportData.data)
                    .padding(.top, -10.0)
            }
            
        }
        .padding(.horizontal, 25.0)
    }
}

// List Items View
struct ListViewItem: View {
    var report: Report
    
    var body: some View {
        NavigationLink(destination: HomeListRowView(report: report)) {
            HStack(alignment: .center) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.orange)
                    .font(.largeTitle)
                
                // Title/Desc
                VStack(alignment: .leading) {
                    Text(report.type)
                        .font(.title3)
                    Text("\(report.suburb) - \(report.location)")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct ListView: View {
    var data: [Report]
    
    var body: some View {
        List {
            Section {
                ForEach(data) { report in
                    ListViewItem(report: report)
                }
            } header: {
                Text("Recent Activities")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
        }
        .scrollContentBackground(.hidden)
        .padding(/*@START_MENU_TOKEN@*/.leading, -35.0/*@END_MENU_TOKEN@*/)
        .padding(/*@START_MENU_TOKEN@*/.top, 10.0/*@END_MENU_TOKEN@*/)
    }
}
