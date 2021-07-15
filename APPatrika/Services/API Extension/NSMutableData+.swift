//
//  NSMutableData+.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import Foundation

extension NSMutableData {
  public func appendString(_ string: String) {
    if let data = string.data(using: .utf8) {
      self.append(data)
    }
  }
}
