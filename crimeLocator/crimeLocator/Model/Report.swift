//
//  Report.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class Report: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case date
        case suburb
    }
    
    init(id: Int, type: String, date: Date, suburb: Suburb) {
        self.id = id
        self.type = type
        self.date = date
        self.suburb = suburb
    }
    
    var id: Int
    var type: String
    var date: Date
    var suburb: Suburb
}
