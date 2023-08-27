//
//  DataLoader.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class DataLoader<T: Codable> {
    var data = [T]()
    var resource: String
    
    init(resource: String) {
        self.resource = resource
        loaddata()
    }
    
    // Method to load data from a JSON file
    func loaddata() {
        
        // Create a URL object for the JSON file in the main bundle
        // If the file isn't found, print an error message and return
        guard let url = Bundle.main.url(forResource: self.resource, withExtension: "json")
        else {
            print("JSON \(resource) could be found")
            return
        }
        
        do {
            // Read data from the URL
            let data = try Data(contentsOf: url)
            
            // Create a JSONDecoder object
            let decoder = JSONDecoder()
            
            decoder.dateDecodingStrategy = .custom { decoder in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let date = dateFormatter.date(from: dateString) {
                    return date
                }
                throw DecodingError.dataCorruptedError(in: container,
                    debugDescription: "Invalid date: \(dateString)")
            }
            
            // Decode the JSON data into an array of type [T]
            self.data = try decoder.decode([T].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
