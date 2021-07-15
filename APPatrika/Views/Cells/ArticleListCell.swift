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
            ArticleRemoteImage(urlString: "\(article.id)/" + article.issueImage)
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(article.issueName)
                    .font(.system(size: 20))
                    .fontWeight(.regular)
                Text(article.newImageName)
                    .font(.subheadline)
                    .fontWeight(.light)
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
