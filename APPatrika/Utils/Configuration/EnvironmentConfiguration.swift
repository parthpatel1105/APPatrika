//
//  EnvironmentConfiguration.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import Foundation

final class EnvironmentConfiguration {
    private let config: NSDictionary
    
    init(dictionary: NSDictionary) {
        config = dictionary
    }
    
    convenience init() {
        let bundle = Bundle.main
        let configPath = bundle.path(forResource: "config", ofType: "plist")!
        let config = NSDictionary(contentsOfFile: configPath)!
        
        let dict = NSMutableDictionary()
        if let commonConfig = config["Common"] as? [AnyHashable: Any] {
            
            dict.addEntries(from: commonConfig)
            
        }
        if let environment = bundle.infoDictionary!["ConfigEnvironment"] as? String {
            if let environmentConfig = config[environment] as? [AnyHashable: Any] {
                dict.addEntries(from: environmentConfig)
            }
        }
        
        self.init(dictionary: dict)
    }
}


extension EnvironmentConfiguration {
    var baseApiUrl : String {
        return config["BaseAPIURL"] as! String
    }
    
    var imageURL : String {
        return config["ImageURL"] as! String
    }
    
    var balPatrikaDownloadURL : String {
        return config["BalPatrikaDownloadURL"] as! String
    }
    
    var issueURL : String {
        return config["IssueURL"] as! String
    }
    
    var googleClientId: String {
        return config["GoogleClientId"] as! String
    }
    
    var oneSignalAppId: String {
        return config["OneSignalAppId"] as! String
    }
    
    var appCenterKey: String {
        return config["AppCenterKey"] as! String
    }
}


protocol NSScreencastConfiguration {
    var baseApiUrl: String { get }
    var imageURL: String { get }
    var balPatrikaDownloadURL: String { get }
    var issueURL: String { get }
    var googleClientId: String { get }
    var oneSignalAppId: String { get }
    var appCenterKey: String { get }
}

extension EnvironmentConfiguration : NSScreencastConfiguration { }
