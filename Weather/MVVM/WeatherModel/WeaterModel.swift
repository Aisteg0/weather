//
//  WeaterModel.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

struct WeatherModel: Codable, Identifiable {
    var id: String { UUID().uuidString }
    let location : Location?
    let current : Current?
    let forecast : Forecast?
    
    enum CodingKeys: String, CodingKey {
        
        case location = "location"
        case current = "current"
        case forecast = "forecast"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        current = try values.decodeIfPresent(Current.self, forKey: .current)
        forecast = try values.decodeIfPresent(Forecast.self, forKey: .forecast)
    }
    
}
