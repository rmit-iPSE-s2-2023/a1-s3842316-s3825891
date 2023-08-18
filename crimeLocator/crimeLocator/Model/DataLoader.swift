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
        
        let data = try? Data(contentsOf: url)
        let json = try? JSONDecoder().decode([T].self, from: data!)
        self.data = json ?? []
    }
}
