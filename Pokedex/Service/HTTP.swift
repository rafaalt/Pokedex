//
//  HTTP.swift
//  Pokedex
//
//  Created by Rafael Torga on 24/07/24.
//

import Foundation

enum HTTP {
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum Headers {
        
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
}
