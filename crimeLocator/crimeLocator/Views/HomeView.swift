//
//  HomeView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    var user: User
    var reports: [Report]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta + 0.1, longitudeDelta: MapConstants.defaultLongitudeDelta + 0.1)
    )
    
    @State private var locations: [Locations] = []
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20.0) {
                Text("Welcome \(self.user.fullName)!")
                    .font(.title)
                    .padding(.top, 10.0)
                
                SearchBar(data: self.reports, user: user)
                // Text("\(user.favorites[0].name)")
                
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    annotationItems: locations,
                    annotationContent: { location in
                    MapMarker(coordinate: location.coordinates, tint: .orange)
                })
                    .frame(height: 380)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: -5)
                
                ListView(data: reports)
                    .padding(.top, -10.0)
            }
            .padding(.horizontal, 25.0)
            .onAppear {
                for report in reports {
                    geocodePostcode(postcode: String(report.suburb.postcode), report: report)
                }
            }
        }
    }
    // Postcode to coordinate converter
    private func geocodePostcode(postcode: String, report: Report) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(postcode) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            // Coordinate
            if let location = placemarks?.first?.location {
                let newLocation = Locations(name: report.suburb.city, postcode: report.suburb.postcode, coordinates: location.coordinate)
                    locations.append(newLocation)
                
            }
        }
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
                
                VStack(alignment: .leading) {
                    Text(report.type)
                        .font(.headline)
                    Text("\(report.suburb.name) - \(report.suburb.city)")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
//        var userData = DataLoader<User>(resource: "UserData")
        let reportData = DataLoader<Report>(resource: "ReportData")
        HomeView(user: User.getUser(email: "johndoe2@gmail.com"), reports: reportData.data)
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
