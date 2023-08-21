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


    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20.0) {
                    Text("Welcome Back!")
                        .font(.largeTitle)
                        .padding(.top, 10.0)                    // Search bar as a NavigationLink
                SearchBar(data: reportData.data)
                
                // Map
                Map(coordinateRegion: $region)
                    .frame(width: 379, height: 469)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5) // Drop shadow
                
                List {
                    Text("Recent Activities")
                        .foregroundColor(.gray)
                        .font(.caption)
                    ForEach(reportData.data) { report in
                        ListView(report: report)
                    }
                }
                .padding(.top, -10)
                
                // Pushes Search bar and map to top
                Spacer()
            }
            .padding(.horizontal, 25.0)
        }
    }
}

// List Items View
struct ListView: View {
    var report: Report
    
    var body: some View {
        NavigationLink(destination: HomeListRowView(report: report)) { // Destination page
            HStack(alignment: .center) {
                // Pin Icon
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.orange)
                    .font(.title2)

                // Title/Desc
                VStack(alignment: .leading) {
                    Text(report.type)
                        .font(.subheadline)
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
