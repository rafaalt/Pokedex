//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var pokemon: [Pokemon] = []
    @Published var hasError: Bool = false
    @Published var loadingMore: Bool = false
    private var useCase: HomeUseCase
    private var nextPage: String?
    private var previousPage: String?
    
    
    init() {
        self.useCase = HomeUseCase()
        startSearch()
    }
    
    func startSearch() {
        useCase.getPokemonsUrls() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.nextPage = response.next
                    self?.previousPage = response.previous
                    for pokemon in response.results {
                        self?.getPokemonByUrl(url: pokemon.url)
                    }
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
    func nextSearch() {
        guard let next = nextPage else { return }
        nextPage = nil
        if !loadingMore {
            loadingMore = true
            useCase.getPokemonsUrls(url: next) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.nextPage = response.next
                        self?.previousPage = response.previous
                        for pokemon in response.results {
                            self?.getPokemonByUrl(url: pokemon.url)
                        }
                        self?.loadingMore = false
                    case .failure(let error):
                        print("ERROR: \(error)")
                        self?.loadingMore = false
                    }
                }
            }
        }
    }
    
    func getPokemonByUrl(url: String) {
        useCase.getPokemonByUrl(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self?.addPokemonInOrder(pokemon)
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
    func getPokemon(id: Int) {
        useCase.getPokemon(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self?.addPokemonInOrder(pokemon)
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
    private func addPokemonInOrder(_ newPokemon: Pokemon) {
        if let index = self.pokemon.firstIndex(where: { $0.id > newPokemon.id }) {
            self.pokemon.insert(newPokemon, at: index)
        } else {
            self.pokemon.append(newPokemon)
        }
    }
}
