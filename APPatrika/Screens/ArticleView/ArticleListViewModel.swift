//
//  ArticleListViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import SwiftUI

final class ArticleListViewModel: ObservableObject {
    
    @Published var articles: [ArticlesModel] = []
    @Published var alertType: AlertType? = nil
    @Published var isLoading = false
    
    func getArticles() {
        isLoading = true
        NetworkManager.shared.fetchAPI(request: APIEndpoint.getArticle.getURLRequest()) { [weak self] (result: Result<[ArticlesModel], ErrorMessage>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    Logger.log(error.localizedDescription)
                    self.showError(error: error)
                }
            }
            
        }
    }
    
    private func showError(error: ErrorMessage) {
        switch error {
        case .invalidResponse:
            self.alertType = .ok(title: "Server Error", message: "Invalid response from the server. Please try again later or contact support.")
        case .invalidData:
            self.alertType = .ok(title: "Server Error", message: "The data received from the server was invalid. Please contact support.")
        case .unableToComplete:
            self.alertType = .ok(title: "Server Error", message: "Unable to complete your request at this time. Please check your internet connection.")
        case .invalidURL:
            self.alertType = .ok(title: "Server Error", message: "There was an issue connecting to the server. If this persists, please contact support.")
        }
    }
}
