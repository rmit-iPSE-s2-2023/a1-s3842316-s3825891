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
            center: CLLocationCoordinate2D(latitude: -27.46980, longitude: 153.0251),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

    var body: some View {
        NavigationView {
            VStack {
                // Search bar as a NavigationLink
                NavigationLink(destination: HomeSearchPageView()) {
                    HStack {
                        Image(systemName: "magnifyingglass") // Search icon
                            .foregroundColor(.gray)
                        Text("Search")
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .buttonStyle(PlainButtonStyle())
                
                // Map
                Map(coordinateRegion: $region)
                    .frame(width: 379, height: 469)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5) // Drop shadow
                
                // Recent Activities List
                List {
                    Text("Recent Activities")
                        .foregroundColor(.gray)
                        .font(.caption)
                    ListView(title: "Location 1", desc: "Desc for location 1")
                    ListView(title: "Location 2", desc: "Desc for location 2")
                    ListView(title: "Location 3", desc: "Desc for location 1")
                    ListView(title: "Location 4", desc: "Desc for location 2")
                    ListView(title: "Location 5", desc: "Desc for location 1")
                    ListView(title: "Location 6", desc: "Desc for location 2")
                }
                .padding(.top, -10)
                
                // Pushes Search bar and map to top
                Spacer()
            }
        }
    }
}

// List Items View
struct ListView: View {
    var title: String
    var desc: String
    
    var body: some View {
        NavigationLink(destination: HomeListRowView()) { // Destination page
            HStack(alignment: .center) {
                
                // Pin Icon
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.orange)
                    .font(.title2)
                
                // Title/Desc
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                    Text(desc)
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
