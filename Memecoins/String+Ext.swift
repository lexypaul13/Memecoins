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
}
