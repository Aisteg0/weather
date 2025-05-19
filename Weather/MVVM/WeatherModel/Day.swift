//
//  Day.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

struct Day : Codable {
    let avgtemp_c : Double?
    let maxwind_kph : Double?
    let avghumidity : Int?

    enum CodingKeys: String, CodingKey {

        case avgtemp_c = "avgtemp_c"
        case maxwind_kph = "maxwind_kph"
        case avghumidity = "avghumidity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avgtemp_c = try values.decodeIfPresent(Double.self, forKey: .avgtemp_c)
        maxwind_kph = try values.decodeIfPresent(Double.self, forKey: .maxwind_kph)
        avghumidity = try values.decodeIfPresent(Int.self, forKey: .avghumidity)
    }

}
