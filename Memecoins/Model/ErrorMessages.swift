//
//  ErrorMessages.swift
//  Memecoins
//
//  Created by Alex Paul on 5/22/21.
//

import Foundation

enum ErroMessage : String, Error{
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURL = "Not a valid URL"
}
