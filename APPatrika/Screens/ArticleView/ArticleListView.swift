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
                   ArticleListCell(article: article)
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Patrika")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            viewModel.getArticles()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                )
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
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
