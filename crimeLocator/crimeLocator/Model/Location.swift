//
//  Location.swift
//  crimeLocator
//
//  Created by Sahibjeet Singh on 26/8/2023.
//

import Foundation
import MapKit

struct Locations: Identifiable {
    let name:String
    let postcode:Int
    let coordinates: CLLocationCoordinate2D
    
    var id:String{
        name+String(postcode)
    }
}
