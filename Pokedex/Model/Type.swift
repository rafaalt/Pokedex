//
//  Type.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

struct PokemonType: Codable {
    var id: Int?
    var name: String
    var url: String
}

enum Types: String {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case stellar
    case unknown
}
