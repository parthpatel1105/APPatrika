//
//  HistoryViewModel.swift
//  APPatrika
//
//  Created by Parth Patel on 23/07/21.
//

import Foundation

final class HistoryViewModel: ObservableObject {
//    @Published var articles: [ArticlesModel] = [MockData.sampleArticles, MockData.sampleArticles]
//    @Published var testArticles: [ArticlesModel] = [MockData.sampleArticles, MockData.sampleArticles, MockData.sampleArticles, MockData.sampleArticles]
    @Published var articles: [URL] = []
    @Published var balPatrika: [URL] = []
    lazy var appFileStorage = AppFileStorage()
    
    func getBalPatrikaDirectories(for directory: SubDirectories) {
        let url = appFileStorage.getURL(for: .subDirectory(dir: directory))
        self.balPatrika = appFileStorage.listDirectories(directory: url) ?? []
    }
    
    func getArticlesDirectories(for directory: SubDirectories) {
        let url = appFileStorage.getURL(for: .subDirectory(dir: directory))
        self.articles = appFileStorage.listDirectories(directory: url) ?? []
    }
}
