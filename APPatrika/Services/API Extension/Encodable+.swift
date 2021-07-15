//
//  Encodable+.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import Foundation

extension Encodable {
    public func toJSONData()throws -> Data { try JSONEncoder().encode(self) }
    public func toJSONData(_ encoder: JSONEncoder) throws -> Data {try encoder.encode(self)}
}
