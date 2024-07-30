//
//  Int+Extensions.swift
//  Pokedex
//
//  Created by Rafael Torga on 28/07/24.
//

extension Int {
    func formattedWithLeadingZeros(minimumDigits: Int) -> String {
        return String(format: "%0\(minimumDigits)d", self)
    }
}

