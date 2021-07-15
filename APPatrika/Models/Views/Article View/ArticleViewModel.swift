//
//  ArticleViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import SwiftUI

final class ArticleViewModel: ObservableObject {
    
    @Published var articles: [Articles] = []

    func getArticles() {
        NetworkManager.shared.fetchAPI(request: APIEndpoint.getArticle.getURLRequest()) { [self] (result: Result<[Articles], ErrorMessage>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    Logger.log(error.localizedDescription)
                }
            }
            
        }
    }
}
