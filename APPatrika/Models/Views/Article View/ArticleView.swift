//
//  ArticleView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct ArticleView: View {
    
    @StateObject var viewModel = ArticleViewModel()
    
    var body: some View {
        List(viewModel.articles) { article in 
           ArticleListCell(article: article)
        }
        .onAppear {
            viewModel.getArticles()
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView()
    }
}
