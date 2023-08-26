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

class SuburbList: ObservableObject {
    @Published var pinnedSuburbs: [Suburb]
    @Published var unPinnedSuburbs: [Suburb]
    
    init(pinnedSuburbs: [Suburb], unPinnedSuburbs: [Suburb]) {
        self.pinnedSuburbs = pinnedSuburbs
        self.unPinnedSuburbs = unPinnedSuburbs
    }
    
    func unPin(suburb: inout Suburb) {
        suburb.togglePinned()
        self.removePinnedSuburb(suburb: suburb)
        self.unPinnedSuburbs = self.unPinnedSuburbs + [suburb]
    }
    
    func pin(suburb: inout Suburb) {
        suburb.togglePinned()
        self.removeUnPinnedSuburb(suburb: suburb)
        self.pinnedSuburbs = self.pinnedSuburbs + [suburb]
    }
    
    func removePinnedSuburb(suburb: Suburb) {
        self.pinnedSuburbs = self.pinnedSuburbs.filter({$0.id != suburb.id})
    }
    
    func removeUnPinnedSuburb(suburb: Suburb) {
        self.unPinnedSuburbs = self.pinnedSuburbs.filter({$0.id != suburb.id})
    }
}
