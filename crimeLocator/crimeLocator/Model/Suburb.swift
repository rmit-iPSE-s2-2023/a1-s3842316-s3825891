//
//  Suburb.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 25/8/2023.
//

import Foundation

struct Suburb: Codable, Identifiable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case postcode
        case city
        case pinned
    }
    
    var id: Int
    var name: String
    var postcode: Int
    var city: String
    var pinned: Bool
    
    mutating func togglePinned() {
        self.pinned.toggle()
    }
}
