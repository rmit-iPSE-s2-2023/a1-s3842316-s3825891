//
//  User.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class User: Codable, Identifiable, ObservableObject {
    
    enum CodingKeys: String, CodingKey {
        case email
        case fullName
        case favorites
    }
    
    // Properties of the User class
    var id = UUID()
    var email: String
    var fullName: String
    @Published var favorites: [Suburb]
    
    static private var allUsers = [User]()
    
    // Required initializer for decoding from JSON format
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.email = try container.decode(String.self, forKey: .email)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.favorites = try container.decode([Suburb].self, forKey: .favorites)
    }
    
    init(email: String, fullName: String) {
        self.email = email
        self.fullName = fullName
        self.favorites = [Suburb]()
    }
    
    // Method for encoding to JSON
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(favorites, forKey: .favorites)
    }
    
    // To remove a favorite suburb
    func removeFavorite(suburb: Suburb) {
        print("removing \(suburb)")
        self.favorites = self.favorites.filter( {
            return $0.id != suburb.id
       })
    }
    
    // Method to add a favorite suburb
    func addFavorite(suburb: Suburb) {
        self.favorites.append(suburb)
    }
    
    // Method to toggle the pinned status of a suburb
    func toggle(suburb: String) {
        var sub = self.favorites.first(where: {$0.name == suburb})
        self.favorites = self.favorites.filter({$0.name != sub?.name})
        sub?.togglePinned()
        if (sub != nil) {
            self.favorites.append(sub!)
        }
    }
    
    // Static method to get a User object based on email
    static func getUser(email: String) -> User {
        if allUsers.count == 0 {
            User.allUsers = DataLoader<User>(resource: "UserData").data
        }
        
        if let user = User.allUsers.first(where: {$0.email == email}) {
            return user
        }
        return User(email: "testUser@gmail.com", fullName: "test user")
    }
}
