//
//  HomeService.swift
//  Pokedex
//
//  Created by Rafael Torga on 22/07/24.
//

import Alamofire
import Foundation

class APIService {
    func fetchData<T: Codable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(request).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(T.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(.decodingFailed))
                }
            case .failure:
                completion(.failure(.requestFailed))
            }
        }
    }
}

enum NetworkError: Error {
    case requestFailed
    case decodingFailed
}
