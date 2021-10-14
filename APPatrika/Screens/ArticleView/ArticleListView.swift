//
//  ArticleListView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct ArticleListView: View {
    
    @StateObject var viewModel = ArticleListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.articles) { article in
                    NavigationLink(destination: ArticleDetailView(issueId: article.id, articleTitle: article.issueName)) {
                        ArticleListCell(article: article)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Patrika")
                .navigationBarItems(trailing: refreshButton)
            }
            .onAppear {
                viewModel.getArticles()
            }
                        
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertType) { $0.alert }
        
    }
    
    private var refreshButton: some View {
        return AnyView(Button(action: reloadView) { Image(systemName: "arrow.clockwise") })
    }
    
    private func reloadView() {
        viewModel.getArticles()
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
