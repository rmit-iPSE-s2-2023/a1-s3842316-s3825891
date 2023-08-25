//
//  User.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class User: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case email
        case fullName
        case favorites
    }
    
    var id = UUID()
    var email: String
    var fullName: String
    var favorites: [Suburb]

    
    func removeFavorite(suburb: Suburb) {
        self.favorites = self.favorites.filter( {
            return $0 != suburb
       })
    }
}
