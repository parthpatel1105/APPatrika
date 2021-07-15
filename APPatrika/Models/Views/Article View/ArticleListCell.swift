//
//  ArticleListCell.swift
//  APPatrika
//
//  Created by Parth Patel on 14/07/21.
//

import SwiftUI

struct ArticleListCell: View {
    let article: Articles
    
    var body: some View {
        HStack {
            Image("")
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 90)
                .cornerRadius(8)
                .foregroundColor(.red)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(article.issueName)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Text(article.newImageName)
                    .font(.footnote)
                    .fontWeight(.light)

//                Text("$\(article.price, specifier: "%.2f")")
//                    .foregroundColor(.secondary)
//                    .fontWeight(.semibold)
            }
            .padding(.leading)
        }
    }
}

struct ArticleListCell_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListCell(article: MockData.sampleArticles)
    }
}
