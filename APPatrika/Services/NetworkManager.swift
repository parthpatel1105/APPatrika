//
//  NetworkManager.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import UIKit

enum APIEndpoint {
    case getArticle
    case getImage(imagePath: String)
}

extension APIEndpoint: API {
    // base URL
    
    var configuration: EnvironmentConfiguration {
        return EnvironmentConfiguration.init()
    }
    
    var baseURL: URL {
        switch self {
        case .getArticle:
            return URL(string: configuration.baseApiUrl)!
        case .getImage( _):
        return URL(string: configuration.imageURL)!
        }
        
    }
    
    // End point path
    var path: String {
        switch self {
        case .getArticle:
            return "patrika_get_issues.php"
        case .getImage(let imagePath):
            return "IssueImages/\(imagePath)"
        }
    }
    // HTTP method of endpoint
    var method: Method {
        switch self {
        case .getArticle, .getImage:
            return .get
        }
    }
    
    var sampleData: Data {
        // for mocking requests
        Data()
    }
    
    var task: Task {
        switch self {
        case .getArticle, .getImage:
            return .requestPlain
        }
    }
    
    // Headers for request
    var headers: [String: String]? {
        return nil
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    var defaultSession = URLSession(configuration: .ephemeral)
    //var dataTask: URLSessionDataTask?
    
    func fetchAPI<T: Codable>(request: URLRequest?, completed: @escaping (Result<T, ErrorMessage>) -> Void) {
        //dataTask?.cancel()
        guard let request = request else { return }
        NetworkLogger.log(request: request)
        
        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        session.loadData(with: request) { [weak self] data, response, error in
            //        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            guard let _ = self else { return }
            //            defer {
            //                self.dataTask = nil
            //            }
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                Logger.log("Get success response")
                completed(.success(responseObject))
            } catch {
                print("decode error = \(error)")
                completed(.failure(.invalidData))
            }
        }
        
    }
    
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        let request = APIEndpoint.getImage(imagePath: urlString).getURLRequest()
        guard let request = request else { return }

        URLSession.shared.loadData(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
    }
    
}

protocol NetworkLoader {
    func loadData(with request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkLoader {
    
    // call dataTask and resume, passing the completionHandler
    func loadData(with request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: request, completionHandler: completion).resume()
    }
}
