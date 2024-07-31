//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Rafael Torga on 30/07/24.
//

import Kingfisher
import SwiftUI

struct PokemonDetailsView: View {
    
    var pokemon: Pokemon
    @State private var isShiny = false
    @State private var isFront = true
    @State private var selectedImage: String
    
    init(pokemon: Pokemon, isShiny: Bool = false, isFront: Bool = true) {
        self.pokemon = pokemon
        self.isShiny = isShiny
        self.isFront = isFront
        self.selectedImage = pokemon.sprites.front_default ?? ""
    }
    
    var body: some View {
        VStack {
            pokemonId
            pokemonName
            shinyText
            ZStack {
                pokemonImage
                VStack {
                    HStack {
                        Button(action: {
                            changeShiny()
                        }) {
                            Image(isShiny ? "shinyYes" : "shinyNo")
                                .resizable()
                        }
                        .frame(width: 50, height: 50)
                        .padding(16)
                        Spacer()
                        Button(action: {
                            changePosition()
                        }) {
                            Image(isFront ? "frontYes" : "frontNo")
                                .resizable()
                        }
                        .frame(width: 50, height: 50)
                        .padding(16)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(Color(pokemon.types[0].type.name))
            .cornerRadius(32)
            .padding(.horizontal, 32)
            Spacer()
        }
    }
    
    // MARK: - VIEWS
    
    var pokemonName: some View {
        Text(pokemon.name.firstLetterUpperCased())
            .font(.largeTitle)
            .bold()
    }
    
    var pokemonId: some View {
        Text("#\(pokemon.id.formattedWithLeadingZeros(minimumDigits: 3))")
            .font(.title)
            .bold()
            .foregroundStyle(.gray)
            .padding(.top, 8)
    }
    
    var shinyText: some View {
        Text("Shiny")
            .font(.title2)
            .bold()
            .foregroundStyle(isShiny ? .orange : .clear)
    }
    
    var pokemonImage: some View {
        KFImage(URL(string: selectedImage))
            .placeholder {
                Image("pokeball")
                    .resizable()
                    .scaledToFit()
                    .padding(100)
            }
            .resizable()
            .scaledToFit()
            .padding(.vertical, 24)
    }
    
    //MARK: - PRIVATE METHODS
    
    private func changeShiny() {
        isShiny = !isShiny
        newSelectedImage()
    }
    
    private func changePosition() {
        isFront = !isFront
        newSelectedImage()
    }
    
    private func newSelectedImage() {
        if isFront {
            selectedImage = (isShiny ? pokemon.sprites.front_shiny : pokemon.sprites.front_default) ?? ""
        }
        else {
            selectedImage = (isShiny ? pokemon.sprites.back_shiny : pokemon.sprites.back_default) ?? ""
        }
    }
}

#Preview {
    PokemonDetailsView(pokemon: .init(id: 1, name: "Charizard", is_default: true, height: 100, weight: 100, sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/465.png", front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/465.png"), types: [.init(slot: 1, type: .init(name: "fire", url: ""))]))
}
