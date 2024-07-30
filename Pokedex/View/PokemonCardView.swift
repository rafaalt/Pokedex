//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Rafael Torga on 28/07/24.
//

import Kingfisher
import SwiftUI

struct PokemonCardView: View {
    
    var pokemon: Pokemon
    var perRow: framePerSize = .two
    
    var body: some View {
        VStack {
            pokemonImage
            pokemonName
            pokemonId
        }
        .frame(width: perRow.widthSize, height: perRow.widthSize)
        .background(Color(pokemon.types[0].type.name))
        .cornerRadius(10)
    }
    
    var pokemonImage: some View {
        KFImage(URL(string: pokemon.sprites.front_default ?? ""))
            .placeholder {
                Image("pokebola")
                    .resizable()
                    .scaledToFit()
            }
            .resizable()
            .scaledToFit()
    }
    
    var pokemonName: some View {
        Text(pokemon.name.firstLetterUpperCased())
            .bold()
            .foregroundStyle(Color.black)
            .font(perRow.titleFont)
    }
    
    var pokemonId: some View {
        Text("#\(pokemon.id.formattedWithLeadingZeros(minimumDigits: 3))")
            .foregroundStyle(Color.gray)
            .font(perRow.idFont)
    }
}

enum framePerSize {
    case one
    case two
    case three
    
    var widthSize: CGFloat {
        switch self {
        case .one: return 300
        case .two: return 160
        case .three: return 120
        }
    }
    
    var titleFont: Font {
        switch self {
        case .one: return .largeTitle
        case .two: return .title2
        case .three: return .title3
        }
    }
    
    var idFont: Font {
        switch self {
        case .one: return .title
        case .two: return .title3
        case .three: return .body
        }
    }
}


#Preview {
    PokemonCardView(pokemon: .init(id: 1, name: "charizard", is_default: true, height: 100, weight: 100, sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png"), types: [.init(slot: 10, type: .init(name: "electric", url: ""))]), perRow: .one)
}


