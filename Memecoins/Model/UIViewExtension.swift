//
//  UIViewExtension.swift
//  Memecoins
//
//  Created by Alex Paul on 8/10/21.
//

import UIKit

extension UIViewController{
    func alert(message: String, title: String = "") {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
}
