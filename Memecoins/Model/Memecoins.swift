// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
class Memecoins:Decodable, Equatable, Encodable {
  
    static func == (lhs: Memecoins, rhs: Memecoins) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.price == rhs.price &&
            lhs.price_BNB == rhs.price_BNB &&
            lhs.simple == rhs.simple
    }
    
    var name:String = ""
    var price: String = ""
    var price_BNB :String = ""
    var simple :String = ""
    
//    override init() {
//        super.init()
//    }
//    
    init(withDicitonary:[String:Any]){
        if let value = withDicitonary["name"] as? String{
            name = value
        }
        
        if let value = withDicitonary["price"] as? String{
            price = value
        }
        if let value = withDicitonary["price_BNB"] as? String{
            price_BNB = value
        }
        if let value = withDicitonary["symbol"] as? String{
            simple = value
        }
        
    }
    
    
    
    
}
