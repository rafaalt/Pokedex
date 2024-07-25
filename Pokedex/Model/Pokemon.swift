//
//  Pokemon.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

struct Pokemon: Codable {
    var id: Int
    var name: String
    var is_default: Bool
    var height: Int
    var weight: Int
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.is_default = try container.decode(Bool.self, forKey: .is_default)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
    }
}
