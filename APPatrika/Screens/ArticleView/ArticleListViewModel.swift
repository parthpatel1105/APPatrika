//
//  ArticleListViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import SwiftUI

final class ArticleListViewModel: ObservableObject {
    
    @Published var articles: [Articles] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getArticles() {
        isLoading = true
        NetworkManager.shared.fetchAPI(request: APIEndpoint.getArticle.getURLRequest()) { [weak self] (result: Result<[Articles], ErrorMessage>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    Logger.log(error.localizedDescription)
                    switch error {
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    }
                }
            }
            
        }
    }
}
