//
//  City.swift
//  Cities
//
//  Created by Chittapon Thongchim on 12/9/2565 BE.
//

import Foundation

struct City: Decodable {
    
    let country: String
    let name: String
    let id: Int
    let coordinate: Coordinate
    
    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinate = "coord"
    }
    
    struct Coordinate: Decodable {
        let lat: Double
        let lon: Double
    }
}

