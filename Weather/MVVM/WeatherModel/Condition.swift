//
//  Condition.swift
//  Weather
//
//  Created by Михаил Ганин on 19.05.2025.
//

import Foundation

struct Condition : Codable {
    let text : String?
    let icon : String?

    enum CodingKeys: String, CodingKey {

        case text = "text"
        case icon = "icon"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }

}
