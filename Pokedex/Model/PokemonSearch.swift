//
//  PokemonSearch.swift
//  Pokedex
//
//  Created by Rafael Torga on 28/07/24.
//

import Foundation

struct PokemonSearch: Codable {
    var count: Int
    var next: String?
    var previous: String?
    var results: [PokemonResult]
}

struct PokemonResult: Codable {
    var name: String
    var url: String
}
