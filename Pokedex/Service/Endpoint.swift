//
//  Endpoint.swift
//  Pokedex
//
//  Created by Rafael Torga on 24/07/24.
//

import Foundation

enum Endpoint {
    
    case getPokemonsUrls(url: String = "/api/v2/pokemon")
    case getPokemon(url: String = "/api/v2/pokemon", id: Int)
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        request.addValues(for: self)
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseURL
        components.port = Constants.port
        components.path = self.path
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var path: String {
        switch self {
        case .getPokemonsUrls(let url): return url
        case .getPokemon(let url, let id): return "\(url)/\(id)"
        }
    }
    
    
    private var queryItems: [URLQueryItem] {
        switch self {
            default: return []
        }
    }
    
    
    private var httpMethod: String {
        switch self {
        case .getPokemon,
             .getPokemonsUrls:
            return HTTP.Method.get.rawValue
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .getPokemon,
             .getPokemonsUrls:
            return nil
        }
    }
}

extension URLRequest {
    
    mutating func addValues(for endpoint: Endpoint) {
        switch endpoint {
        case .getPokemon,
             .getPokemonsUrls:
            break
        }
    }
}
