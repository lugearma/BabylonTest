//
//  Address.swift
//  BabylonTest
//
//  Created by Luis Arias on 6/22/19.
//  Copyright © 2019 Luis Arias. All rights reserved.
//

import Foundation

struct Address: Decodable {
    let street: String
    let suite: String
    // TODO: This could be an enum. (lam)
    let city: String
    let coordinates: (Double, Double)
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case coordinates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.suite = try container.decode(String.self, forKey: .suite)
        self.city = try container.decode(String.self, forKey: .city)
        let geo = try container.decode([String : String].self, forKey: .coordinates)
        
        guard
            let lat = geo["lat"],
            let lng = geo["lng"] else {
                let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Missing coordinates value")
                throw DecodingError.dataCorrupted(context)
        }
        
        guard
            let latitude = Double(lat),
            let longitude = Double(lng) else {
                let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unable to cast coordinates")
                throw DecodingError.dataCorrupted(context)
        }
        
        self.coordinates = (latitude, longitude)
    }
}
