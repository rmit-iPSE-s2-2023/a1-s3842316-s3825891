//
//  DataLoader.swift
//  crimeLocator
//
//  Created by Jainam Doshi on 17/8/2023.
//

import Foundation

class DataLoader<T: Codable>: ObservableObject {
    @Published var data = [T]()
    
    init(resource: String) {
        loaddata(resource: resource)
    }
    
    func loaddata(resource: String) {
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json")
        else {
            print("JSON \(resource) could be found")
            return
        }
        
//        let data = try? Data(contentsOf: url)
//        let json = try? JSONDecoder().decode([T].self, from: data!)
//        self.data = json ?? []
        
        
        do {
            let data = try Data(contentsOf: url)
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
            self.data = try decoder.decode([T].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
