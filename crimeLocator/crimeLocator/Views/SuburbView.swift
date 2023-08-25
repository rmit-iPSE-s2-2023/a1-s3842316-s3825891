//
//  SuburbView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 21/8/2023.
//

import SwiftUI
import MapKit

struct SuburbView: View {
    var suburb: Suburb
    var reports: [Report]
    var user: User
    @State var isFavorite: Bool
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(suburb.name)")
                    .font(.title)
                Spacer()
                Button {
                    user.removeFavorite(suburb: suburb)
                } label: {
                    Image(systemName: self.isFavorite ? "bookmark.fill" : "bookmark")
                        .font(.title)
                }
            }
            
            
            Map(coordinateRegion: $region)
                .frame(width: 379, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            Spacer()
        }
        .padding(.horizontal, 25.0)
    }
}

struct SuburbView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var reportData = DataLoader<Report>(resource: "ReportData")
        @ObservedObject var userData = DataLoader<User>(resource: "UserData")
        
        SuburbView(suburb: userData.data[1].favorites[0], reports: reportData.data.filter({
            $0.suburb.name == userData.data[1].favorites[0].name
        }), user: userData.data[1], isFavorite: false)
    }
}
