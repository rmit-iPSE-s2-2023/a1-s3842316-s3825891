//
//  LogoView.swift
//  crimeLocator
//
//  Created by Sahibjeet Singh on 27/8/2023.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack {
            
            // Full Page Decorative Lines
            GeometryReader { geometry in
                VStack {
                    Divider().background(Color.black)
                    Spacer()
                    Divider().background(Color.black)
                    Spacer()
                    Divider().background(Color.black)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                HStack {
                    Divider().background(Color.black)
                    Spacer()
                    Divider().background(Color.black)
                    Spacer()
                    Divider().background(Color.black)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .rotationEffect(.degrees(-45))
            }
            
            
            // Map icon
            Image(systemName: "map.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.orange)
                .opacity(0.5)
                        
            // Custom Layout for Other Elements
            LogoLayout {
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
                Image(systemName: "shield.fill").font(.largeTitle).foregroundColor(.red)
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
                Image(systemName: "mappin.and.ellipse").font(.largeTitle).foregroundColor(.blue)
            }
        }
        .frame(width: 220, height: 220)
        
    }
}

struct LogoLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let radius = bounds.width / 4.0
        let angle = Angle.degrees(360.0 / Double(subviews.count - 1)).radians
        
        for (index, subview) in subviews.enumerated() {
            if index == 3 {
                subview.place(at: CGPoint(x: bounds.midX, y: bounds.midY), anchor: .center, proposal: .unspecified)
                continue
            }
            
            var adjustedIndex = index
            if index > 3 {
                adjustedIndex -= 1
            }
            
            var point = CGPoint(x: 0, y: -radius).applying(CGAffineTransform(rotationAngle: angle * Double(adjustedIndex)))
            point.x += bounds.midX
            point.y += bounds.midY
            
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
