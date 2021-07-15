//
//  ArticlesModel.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import Foundation

struct Articles: Codable, Identifiable {
    struct IssueDate: Codable {
        var id = UUID()
        let date: String
        let timezoneType: Int
        let timezone: String
        
        private enum CodingKeys: String, CodingKey {
            case date
            case timezoneType = "timezone_type"
            case timezone
        }
    }
    
    let id: Int
    let issueName: String
    let issueImage: String
    let newImageName: String
    let issueDate: IssueDate?
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
    
    static let sampleArticles = Articles(id: 1, issueName: "Test Article", issueImage: "", newImageName: "", issueDate: nil, isStatus: 1)
    
    static let articles       = [sampleArticles, sampleArticles, sampleArticles, sampleArticles]
    
}
