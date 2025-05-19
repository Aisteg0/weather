//
//  Forecastday.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

struct Forecastday: Codable, Identifiable {
    let day: Day?
    var id: String { UUID().uuidString }
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Day.self, forKey: .day)
    }
}
