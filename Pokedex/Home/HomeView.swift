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
                OffsettableScrollView(onReach70Percent: {
                    viewModel.nextSearch()
                }) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.pokemon) { pokemon in
                            PokemonCardView(pokemon: pokemon, perRow: .two)
                        }
                    }
                    .padding()
                    nextButton
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
    
    var nextButton: some View {
        Button(action: {
            viewModel.nextSearch()
        }) {
            Text("Tap me!")
        }
        .buttonStyle(.borderedProminent)
    }
}
