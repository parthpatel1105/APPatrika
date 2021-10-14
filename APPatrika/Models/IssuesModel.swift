//
//  IssuesModel.swift
//  APPatrika
//
//  Created by Parth Patel on 29/09/21.
//

import Foundation

struct IssuesModel: Codable, Identifiable {
    let id = UUID()
    let issueID: Int
    let articleID: Int
    let issueName: String
    let articleTitle: String
    let orgImageName: String
    let newImageName: URL
    let orgArticleFileName: String
    let newArticleFileName: String
    let tagName: String
    
    private enum CodingKeys: String, CodingKey {
        case issueID = "IssueId"
        case articleID = "ArticleId"
        case issueName = "IssueName"
        case articleTitle = "ArticleTitle"
        case orgImageName = "OrgImageName"
        case newImageName = "NewImageName"
        case orgArticleFileName = "OrgArticleFileName"
        case newArticleFileName = "NewArticleFileName"
        case tagName = "TagName"
    }
}
