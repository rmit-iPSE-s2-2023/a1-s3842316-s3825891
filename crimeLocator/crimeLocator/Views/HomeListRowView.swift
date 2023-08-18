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
    
    // Map center - QLD
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
            span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
        )

    var body: some View {
        VStack {
            // Map
            Map(coordinateRegion: $region)
                .frame(width: 379, height: 264)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5) // Drop
                .padding(.bottom, 30)
            
            DataView(title: "Type", text: report.type)
            DataView(title: "Date", text: dateFormatter.string(from: report.date))
            DataView(title: "Postcode", text: String(report.postcode))
            DataView(title: "Location", text: report.location)

            
            Spacer()
        }
        .padding(.top, 20)
        .navigationBarTitle(report.type)
        

    }
    
    // Date formatter
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy 'at' h:mma"
        return formatter
    }()

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



struct HomeListRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListRowView(report: Report(id: 1, type: "Theft", date: Date(), location: "Brisbane", postcode: 4029))
    }
}
