//
//  ErrorMessage.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import Foundation

enum ErrorMessage: String, Error {
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case dataNotFound = "Data not found."
}
