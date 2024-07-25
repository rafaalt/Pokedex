//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

class HomeViewModel: ObservableObject {

    private var useCase: HomeUseCase
    
    init() {
        self.useCase = HomeUseCase()
    }
    
    public func getPokemon(id: Int) {
        useCase.getPokemon(id: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    print(pokemon)
                case .failure(let error):
                    print("ERROR: \(error)")
                }
            }
        }
    }
    
}
