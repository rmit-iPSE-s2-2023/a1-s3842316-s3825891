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
    @ObservedObject var user: User
    
    // Track favorite status
    @State var isFavorite: Bool
    
    // State variables for the map region and locations to be displayed
    // QLD - Brisbane Center
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
    )
    
    // Custom layout grid columns
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                HStack {
                    
                    // Text (Suburb Name)
                    Text("\(suburb.name)")
                        .font(.title)
                    
                    Spacer()
                    
                    Button {
                        // Handle favorite toggle
                        if self.isFavorite {
                            user.removeFavorite(suburb: suburb)
                        } else {
                            user.addFavorite(suburb: suburb)
                        }
                        self.isFavorite.toggle()
                    } label: {
                        Image(systemName: self.isFavorite ? "bookmark.fill" : "bookmark")
                            .font(.title)
                    }
                }
                
                // Map display
                Map(coordinateRegion: $region)
                    .frame(width: 379, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                
                // Report count display
                Text("Reports count: \(reports.count)")
                
                // Custom layout for reports
                if reports.count == 0 {
                    Text("No Reports in \(suburb.name)")
                } else {
                    ForEach(0..<reports.count, id: \.self) { index in
                        if index % 3 == 0 {
                            CustomRectangle(report: reports[index], isLarge: true)
                        } else {
                            HStack {
                                if index < reports.count {
                                    CustomRectangle(report: reports[index], isLarge: false)
                                }
                                if index + 1 < reports.count {
                                    CustomRectangle(report: reports[index + 1], isLarge: false)
                                }
                            }
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 25.0)
        }
    }
}

// Custom rectangle view for each report
struct CustomRectangle: View {
    var report: Report
    var isLarge: Bool

    var body: some View {
        
        NavigationLink(destination: HomeListRowView(report: report)) {
            
            ZStack {
                
                // Rectangle
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.orange.opacity(0.1))
                    .frame(maxWidth: isLarge ? .infinity : nil, maxHeight: isLarge ? 120 : 60)
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.orange, lineWidth: 1)
                
                // Rectangle content
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(Color.orange)
                    Text(report.type)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                }
                .padding([.horizontal, .vertical], 10)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.clear)
    }
}

struct SuburbView_Previews: PreviewProvider {
    static var previews: some View {
        let reportData = DataLoader<Report>(resource: "ReportData")
        let userData = DataLoader<User>(resource: "UserData")
        
        let user = userData.data[1]
        
        SuburbView(suburb: reportData.data[0].suburb, reports: reportData.data, user: user, isFavorite: false)
    }
}
