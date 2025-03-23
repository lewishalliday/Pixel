//
//  FormatNumber.swift
//  Pixel
//
//  Created by Lewis Halliday on 2025-03-23.
//

import Foundation

func formatNumber(_ number: Int) -> String {
    if number < 1000 {
        return "\(number)"
    } else if number < 10000 {
        return NumberFormatter.localizedString(from: NSNumber(value: number), number: .decimal)
    } else if number < 1000000 {
        let formattedNumber = Double(number) / 1000
        return String(format: "%.0fk", formattedNumber)
    } else {
        let formattedNumber = Double(number) / 1000000
        return String(format: "%.1fM", formattedNumber)
    }
}
