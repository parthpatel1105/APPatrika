//
//  ArticlesModel.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import Foundation

struct ArticlesModel: Codable, Identifiable {
  let id: Int
  let issueName: String
  let issueImage: String
  let newImageName: String
  let issueDate: String
  let isStatus: Int

  private enum CodingKeys: String, CodingKey {
    case id = "Id"
    case issueName = "IssueName"
    case issueImage = "IssueImage"
    case newImageName = "NewImageName"
    case issueDate = "IssueDate"
    case isStatus = "IsStatus"
  }
}

struct MockData {
    static let sampleArticles = ArticlesModel(id: 1, issueName: "Test", issueImage: "", newImageName: "", issueDate: "", isStatus: 1)
    
    
    static let sampleBalPatrika = BalPatrikaModel(bPID: 1, bPDate: "", bPTitle: "Title", bPFile: "")
}
