//
//  UsefulFunctions.swift
//  swifty-companion
//
//  Created by Théo Ajavon on 02/05/2024.
//

import Foundation

func getFloorValue(nb: Double) -> Int {
    return Int(floor(nb))
}

func getDecimalValue(nb: Double) -> Double {
    print("\(nb) - \(floor(nb)) = \(nb - floor(nb) + 0.001)")
    return (nb - floor(nb) + 0.001)
}

func getPourcentageOfDecimal(nb: Double) -> Int {
    return Int(getDecimalValue(nb: nb) * 100)
}
