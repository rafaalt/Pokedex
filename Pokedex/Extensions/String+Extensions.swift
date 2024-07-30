//
//  String+Extensions.swift
//  Pokedex
//
//  Created by Rafael Torga on 28/07/24.
//

extension String {
    func firstLetterUpperCased() -> String {
        return prefix(1).uppercased() + self.dropFirst().lowercased()
    }
}
