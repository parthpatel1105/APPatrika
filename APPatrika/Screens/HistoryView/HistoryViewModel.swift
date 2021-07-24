//
//  HistoryViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 23/07/21.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    @Published var articles: [ArticlesModel] = [MockData.sampleArticles, MockData.sampleArticles]
    @Published var testArticles: [ArticlesModel] = [MockData.sampleArticles, MockData.sampleArticles, MockData.sampleArticles, MockData.sampleArticles]

}
