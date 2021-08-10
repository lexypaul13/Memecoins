//
//  String+Ext.swift
//  Memecoins
//
//  Created by Alex Paul on 6/15/21.
//

import Foundation
extension String{
    
    func trunc(length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return self.prefix(length) + trailing
          } else {
            return self
          }
    }
    func convertToDate() -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat()->String{
        guard let date = self.convertToDate()  else { return "N/A"}
        return date.convertToMonthYearFormat()
    }

}

extension Date{
    func convertToMonthYearFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
