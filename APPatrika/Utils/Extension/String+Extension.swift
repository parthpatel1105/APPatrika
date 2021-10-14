//
//  String+Extension.swift
//  APPatrika
//
//  Created by Parth Patel on 26/08/21.
//

import Foundation


protocol StringInterpolation {
    func generateFilePath(firstPath: String, secondPath: String) -> String
}

extension StringInterpolation {
    func generateFilePath(firstPath: String, secondPath: String) -> String {
        return "\(firstPath)/\(secondPath)"
    }
}
