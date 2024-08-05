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
    @State private var gridButtonImages: [String]
    @State private var columns: [GridItem]
    @State private var gridSize: FramePerSize
    
    init() {
        self.gridButtonImages = [
            "square",
            "square.grid.2x2.fill",
            "square.grid.3x3"
        ]
        self.columns = [
            GridItem(.flexible()),
            GridItem(.flexible())]
        self.gridSize = .two
    }
    
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
                            header
                            pokemonGrid
                        }
                    }
                }
            }
        }
    }
    
    private var loadingView: some View {
        VStack {
            Text("Carregando...")
                .bold()
                .foregroundStyle(Color.gray)
            ProgressView()
        }
    }
    
    private var pokedexLogo: some View {
        Image("pokedexLogo")
            .resizable()
            .scaledToFit()
            .padding(.trailing, 100)
            .padding(.vertical, 12)
            .shadow(color: .gray, radius: 1, x: -2, y: 2)
    }
    
    private var header: some View {
        HStack {
            pokedexLogo
            Spacer()
            headerGridButtons
        }
        .padding(.horizontal, 24)
    }
    
    private var headerGridButtons: some View {
        HStack {
            Button(action: {
                pressGridButtons(1)
            }) {
                Image(systemName: gridButtonImages[0])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                pressGridButtons(2)
            }) {
                Image(systemName: gridButtonImages[1])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
            Button(action: {
                pressGridButtons(3)
            }) {
                Image(systemName: gridButtonImages[2])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.blue)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(8)
        .background(Color("lightGray"))
        .cornerRadius(12)
    }
    
    private var pokemonGrid: some View {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemon) { pokemon in
                    NavigationLink(destination: PokemonDetailsView(pokemon: pokemon)) {
                        PokemonCardView(pokemon: pokemon, perRow: gridSize)
                            .shadow(color: .gray, radius: 4, x: -4, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func pressGridButtons(_ buttonPressed: Int) {
        switch buttonPressed {
            case 1:
                gridButtonImages[0] = "square.fill"
                gridButtonImages[1] = "square.grid.2x2"
                gridButtonImages[2] = "square.grid.3x3"
                setColumns(1)
                gridSize = .one
                break
            case 2:
                gridButtonImages[0] = "square"
                gridButtonImages[1] = "square.grid.2x2.fill"
                gridButtonImages[2] = "square.grid.3x3"
                setColumns(2)
                gridSize = .two
                break
            case 3:
                gridButtonImages[0] = "square"
                gridButtonImages[1] = "square.grid.2x2"
                gridButtonImages[2] = "square.grid.3x3.fill"
                setColumns(3)
                gridSize = .three
                break
            default:
                break
        }
    }
    
    private func setColumns(_ number: Int) {
        self.columns = []
        for _ in 1...number {
            self.columns.append(GridItem(.flexible()))
        }
    }
}
