//
//  HomeView.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Kingfisher
import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            if viewModel.pokemon.isEmpty {
                loadingView
            }
            else {
                NavigationView{
                    OffsettableScrollView(onReach70Percent: {
                        viewModel.nextSearch()
                    }) {
                        VStack {
                            pokedexLogo
                            pokemonGrid
                        }
                    }
                }
            }
        }
    }
    
    var loadingView: some View {
        VStack {
            Text("Carregando...")
                .bold()
                .foregroundStyle(Color.gray)
            ProgressView()
        }
    }
    
    var pokedexLogo: some View {
        Image("pokedexLogo")
            .resizable()
            .scaledToFit()
            .padding(.horizontal, 80)
            .padding(.top, 24)
            .padding(.bottom, 8)
            .shadow(color: .gray, radius: 2, x: -2, y: 2)
    }
    
    var pokemonGrid: some View {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemon) { pokemon in
                    NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                        PokemonCardView(pokemon: pokemon, perRow: .two)
                            .shadow(color: .gray, radius: 4, x: -4, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
    }
}
