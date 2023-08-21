//
//  Report.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

struct Report: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case type
        case date
        case suburb
        case location
        case postcode
    }
    
    var id: Int
    var type: String
    var date: Date
    var suburb: String
    var location: String
    var postcode: Int
}
