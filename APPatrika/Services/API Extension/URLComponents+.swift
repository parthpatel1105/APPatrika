//
//  URLComponents+.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import Foundation

extension URLComponents{
    /// Adds parameter as url queries
    /// - Parameter parameters: parameter to encode
    public mutating func addQuery(parameters: [String:Any]){
        self.queryItems = self.queryItems ?? [] + parameters.map {
            if $0.1 is String{
                return URLQueryItem(name: $0.0, value: $0.1 as? String)
            }else{
                return URLQueryItem(name: String($0.0), value: String(describing: $0.1))
            }
        }
        .compactMap{$0}
    }
}

