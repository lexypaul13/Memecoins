// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Memecoins:Codable {
    let updatedAt: Int?
    let data: [String: MemecoinData]?
}

// MARK: - Datum
struct MemecoinData:Codable, Hashable {
    let name, symbol, price, priceBNB: String?
}

