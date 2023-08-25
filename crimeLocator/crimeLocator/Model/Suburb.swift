//
//  Suburb.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 25/8/2023.
//

import Foundation

struct Suburb: Codable, Identifiable, Hashable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case postcode
        case city
    }
    
    var id: Int
    var name: String
    var postcode: Int
    var city: String
}
