//
//  HomeUseCaseProtocol.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Foundation

class HomeUseCase {
    private let service: APIService
    
    init() {
        self.service = APIService()
    }
    
    func getPokemon(id: Int, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        guard let request = Endpoint.getPokemon(id: id).request else {
            completion(.failure(.requestFailed))
            return
        }
        service.fetchData(request: request) { (result: Result<Pokemon, NetworkError>) in
            switch result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
