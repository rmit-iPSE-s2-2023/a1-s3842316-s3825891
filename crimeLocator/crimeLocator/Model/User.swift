//
//  User.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

struct User: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
        case id
        case email
    }
    
    var id: Int
    var email: String
}
