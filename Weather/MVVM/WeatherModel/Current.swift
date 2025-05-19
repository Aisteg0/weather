//
//  Current.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

struct Current : Codable {
    let condition : Condition?

    enum CodingKeys: String, CodingKey {

        case condition = "condition"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        condition = try values.decodeIfPresent(Condition.self, forKey: .condition)
    }

}
