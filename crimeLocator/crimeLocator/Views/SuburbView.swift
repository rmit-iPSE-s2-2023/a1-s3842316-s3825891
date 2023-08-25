//
//  SuburbView.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 21/8/2023.
//

import SwiftUI
import MapKit

struct SuburbView: View {
    var suburb: String
    var reports: [Report]
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: MapConstants.defaultLatitude, longitude: MapConstants.defaultLongitude),
        span: MKCoordinateSpan(latitudeDelta: MapConstants.defaultLatitudeDelta, longitudeDelta: MapConstants.defaultLongitudeDelta)
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(suburb)
            Map(coordinateRegion: $region)
                .frame(width: 379, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
//            ReportListLayout {
//                ForEach(reports) { report in
//                    Text("\(report.id)")
//                        .frame(width: 300, height: 100)
//                        .background(.gray)
//                }
//                //                Text("\(2)")
//                //                    .frame(minWidth: .infinity / 2)
//                //                    .background(.gray)
//            }
//            .background(.green)
            
            Spacer()
        }
        .padding()
    }
}

struct SuburbView_Previews: PreviewProvider {
    static var previews: some View {
        @ObservedObject var reportData = DataLoader<Report>(resource: "ReportData")
        SuburbView(suburb: "Central Buiness District (CBD)", reports: reportData.data.filter({
            $0.suburb == "Central Buiness District (CBD)"
        }))
    }
}

//struct ReportListLayout: Layout {
//    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
////        let subviewSizes = subviews.map { proxy in
////            return proxy.sizeThatFits(.unspecified)
////        }
////
////        // 2
////        let combinedSize = subviewSizes.reduce(.zero) { currentSize, subviewSize in
////            return CGSize(
////                width: currentSize.width + subviewSize.width,
////                height: currentSize.height + subviewSize.height)
////        }
////
////        // 3
////        return combinedSize
//        return proposal.replacingUnspecifiedDimensions()
//    }
//
//    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
//        var point = CGPoint(x: bounds.minX, y: bounds.minY)
//        for (index, subview) in subviews.enumerated() {
//            var size = subview.sizeThatFits(.unspecified)
//            print("height: \(size.height), width: \(size.width)")
//            subview.sizeThatFite
//            subview.place(at: point, anchor: .topLeading, proposal: ProposedViewSize(width: 10.0, height: 10.0))
//
//            point.x += size.width
////            point.y += size.height
//        }
//    }
//
//
//}
