//
//  BalPatrikaModel.swift
//  APPatrika
//
//  Created by Parth Patel on 16/07/21.
//

import Foundation

struct BalPatrikaModel: Codable {
  let bPID: Int
  let bPDate: String
  let bPTitle: String
  let bPFile: String

  private enum CodingKeys: String, CodingKey {
    case bPID = "BPId"
    case bPDate = "BPDate"
    case bPTitle = "BPTitle"
    case bPFile = "BPFile"
  }
}

