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
    
    var logLevel : String {
        return config["LogLevel"] as! String
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
    var logLevel: String { get }
    var googleClientId: String { get }
    var oneSignalAppId: String { get }
    var appCenterKey: String { get }
}

extension EnvironmentConfiguration : NSScreencastConfiguration { }
