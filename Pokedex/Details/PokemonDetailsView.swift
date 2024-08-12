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
    var maxStats: [String : Int]
    @State private var isShiny = false
    @State private var isFront = true
    @State private var selectedImage: String
    
    init(pokemon: Pokemon, maxStats: [String:Int], isShiny: Bool = false, isFront: Bool = true) {
        self.pokemon = pokemon
        self.maxStats = maxStats
        self.isShiny = isShiny
        self.isFront = isFront
        self.selectedImage = pokemon.sprites.front_default ?? ""
    }
    
    var body: some View {
        ScrollView {
            VStack {
                pokemonId
                pokemonName
                shinyText
                pokemonImageZStack
                pokemonTypes
                pokemonData
                pokemonStats
                Spacer()
            }
        }
    }
    
    // MARK: - VIEWS
    
    private var pokemonName: some View {
        Text(pokemon.name.firstLetterUpperCased())
            .font(.largeTitle)
            .bold()
    }
    
    private var pokemonId: some View {
        Text("#\(pokemon.id.formattedWithLeadingZeros(minimumDigits: 3))")
            .font(.title)
            .bold()
            .foregroundStyle(.gray)
            .padding(.top, 8)
    }
    
    private var shinyText: some View {
        Text("Shiny")
            .font(.title2)
            .bold()
            .foregroundStyle(isShiny ? .orange : .clear)
    }
    
    private var pokemonImageZStack: some View {
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
        .frame(height: 400)
        .frame(maxWidth: .infinity, maxHeight: 400)
        .background(Color(pokemon.types[0].type.name))
        .cornerRadius(32)
        .padding(.horizontal, 32)
    }
    
    private var pokemonTypes: some View {
        HStack {
            ForEach(pokemon.types) { type in
                Image("\(type.type.name)Type")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
    }
    
    private var pokemonData: some View {
        HStack {
            Text("Height: ")
                .font(.title3)
            Text("\(pokemon.height) cm")
                .font(.title2)
                .bold()
            Spacer()
            Text("Weight: ")
                .font(.title3)
            Text("\(pokemon.weight) kg")
                .font(.title2)
                .bold()
        }
        .padding(.horizontal, 32)
        .padding(.top, 16)
    }
    
    private var pokemonImage: some View {
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
    
    private var pokemonStats: some View {
        VStack() {
            ForEach(pokemon.stats) { stat in
                StatView(stat: stat, percent: getPercentByStat(stat: stat))
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
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
    
    private func getPercentByStat(stat: Stats) -> CGFloat{
        guard let maxValue = maxStats[stat.stat.name] else { return 0 }
        return CGFloat(stat.base_stat)/CGFloat(maxValue)
    }
}

#Preview {
    PokemonDetailsView(pokemon: .init(id: 1, name: "Charizard", is_default: true, height: 100, weight: 100, stats: [.init(base_stat: 77, effort: 1, stat: .init(name: "hp", url: "")),.init(base_stat: 11, effort: 1, stat: .init(name: "attack", url: ""))], sprites: .init(front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/465.png", front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/465.png"), types: [.init(slot: 1, type: .init(name: "fire", url: ""))]), maxStats: [:])
}
