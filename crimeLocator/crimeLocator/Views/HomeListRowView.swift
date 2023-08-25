//
//  HomeListRowView.swift
//  crimeLocator
//
//  Created by Sahibjeet Singh on 19/8/2023.
//

import SwiftUI
import MapKit

struct HomeListRowView: View {
    var report: Report
    
    // Default Qld Center
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
    )
    
    @State private var locations: [Locations] = []

    var body: some View {
        VStack {
                        
            Map(coordinateRegion: $region,
                annotationItems: locations,
                annotationContent: { location in
                MapMarker(coordinate: location.coordinates, tint: .red)
            })
                .frame(width: 379, height: 264)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                .padding(.bottom, 30)
            
            DataView(title: "Type", text: report.type)
            DataView(title: "Date", text: dateFormatter.string(from: report.date))
            DataView(title: "Postcode", text: String(report.suburb.postcode))
            DataView(title: "Location", text: report.suburb.city)

            
            Spacer()
        }
        .padding(.top, 20)
        .navigationBarTitle(report.type)
        .onAppear {
            geocodePostcode(String(report.suburb.postcode))
        }
    }
    
    // Date formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mma"
        return formatter
    }()
    
    // Postcode to coordinate converter
    private func geocodePostcode(_ postcode: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(postcode) { placemarks, error in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            // Coordinate
            if let location = placemarks?.first?.location {
                // Sets new center point in map
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta))
                
                // Adds location to loc array
                locations = [Locations(name: report.type, postcode: report.suburb.postcode, coordinates: location.coordinate)]
            }
        }
    }
    
}

// Data Items View
struct DataView: View {
    var title: String
    var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(text)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct Locations: Identifiable {
    let name:String
    let postcode:Int
    let coordinates: CLLocationCoordinate2D
    
    var id:String{
        name+String(postcode)
    }
}

struct HomeListRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListRowView(report: Report(id: 1, type: "Theft", date: Date(), suburb: Suburb(id: 1, name: "A", postcode: 2042, city: "Brisbane")))
    }
}
