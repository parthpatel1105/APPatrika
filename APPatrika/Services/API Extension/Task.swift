//
//  Task.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import Foundation

public enum Task{
    
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with data.
    case requestData(Data)
    
    /// A request body set with `Encodable` type
    case requestJSONEncodable(Encodable)
    
    /// A request body set with `Encodable` type and custom encoder
    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
    
    /// A requests body set with data, combined with url parameters.
    case requestCompositeData(bodyData: Data, urlParameters: [String: Any])
    
    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: [String: Any], bodyEncoding: ParameterEncoding, urlParameters: [String: Any])
    
    /// A "multipart/form-data" upload task.
    case uploadMultipart([MultipartFormData])

    /// A "multipart/form-data" upload task  combined with url parameters.
    case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])
}

