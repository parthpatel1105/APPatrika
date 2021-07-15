//
//  NetworkManager.swift
//  IMS
//
//  Created by Parth Patel on 24/01/21.
//

import Foundation

enum APIEndpoint {
    case getArticle    
}

extension APIEndpoint: API {
    // base URL
    
    var configuration: EnvironmentConfiguration {
        return EnvironmentConfiguration.init()
    }
        
    var baseURL: URL {
        return URL(string: configuration.baseApiUrl)!
    }

    // End point path
    var path: String {
        switch self {
        case .getArticle:
            return "patrika_get_issues.php"
        }
    }
    // HTTP method of endpoint
    var method: Method {
        switch self {
        case .getArticle:
            return .get
        }
    }

    var sampleData: Data {
        // for mocking requests
        Data()
    }

    var task: Task {
        switch self {
        case .getArticle:
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
    var defaultSession = URLSession(configuration: .ephemeral)
    var dataTask: URLSessionDataTask?

    func fetchAPI<T: Codable>(request: URLRequest?, completed: @escaping (Result<T, ErrorMessage>) -> Void) {
        dataTask?.cancel()
        guard let request = request else { return }
        NetworkLogger.log(request: request)

        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }

            defer {
                self.dataTask = nil
            }

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
                // sprint(responseObject)
                completed(.success(responseObject))
            } catch {
                print("decode error = \(error)")
                completed(.failure(.invalidData))
            }
        }
        dataTask?.resume()
    }
}
