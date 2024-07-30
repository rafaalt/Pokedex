//
//  Pokemon.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

struct Pokemon: Identifiable, Codable {
    var id: Int
    var name: String
    var is_default: Bool
    var height: Int
    var weight: Int
    var sprites: Sprites
    var types: [PokemonTypes]
    
    init(id: Int, name: String, is_default: Bool, height: Int, weight: Int, sprites: Sprites, types: [PokemonTypes]) {
        self.id = id
        self.name = name
        self.is_default = is_default
        self.height = height
        self.weight = weight
        self.sprites = sprites
        self.types = types
    }
}

struct Sprites: Codable {
    var back_default: String?
    var front_default: String?
    var back_shiny: String?
    var front_shiny: String?
    var back_female: String?
    var back_female_shiny: String?
    var front_female: String?
    var front_fenale_shiny: String?
}

struct PokemonTypes: Codable {
    var slot: Int
    var type: PokemonType
}
