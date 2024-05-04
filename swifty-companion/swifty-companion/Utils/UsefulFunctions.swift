//
//  UsefulFunctions.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 02/05/2024.
//

import SwiftUI
import Foundation

func getFloorValue(nb: Double) -> Int {
    return Int(floor(nb))
}

func getDecimalValue(nb: Double) -> Double {
//    print("\(nb) - \(floor(nb)) = \(nb - floor(nb) + 0.001)")
    return (nb - floor(nb) + 0.001)
}

func getPourcentageOfDecimal(nb: Double) -> Int {
    return Int(getDecimalValue(nb: nb) * 100)
}

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        // Ensure correct format
        guard hexString.count == 6 else {
            self.init(red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)
            return
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
