//
//  Memecoins.swift
//  Memecoins
//
//  Created by Alex Paul on 5/22/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let memecoins = try? newJSONDecoder().decode(Memecoins.self, from: jsonData)

import Foundation

// MARK: - Memecoins
struct Memecoins:Codable {
    let data: Data
}

// MARK: - Datum
struct Data:Codable {
    let name, symbol, price, priceBNB: String?
}
