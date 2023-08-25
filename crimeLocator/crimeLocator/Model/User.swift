//
//  User.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class User: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case email
        case fullName
        case favorites
    }
    
    var id: Int
    var email: String
    var fullName: String
    var favorites: [String]
    
    func removeFavorite(suburb: String) {
        self.favorites = self.favorites.filter( {
           return $0 != suburb
       })
    }
}
