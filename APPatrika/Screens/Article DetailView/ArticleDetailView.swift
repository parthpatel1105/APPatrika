//
//  ArticleDetailView.swift
//  APPatrika
//
//  Created by Parth Patel on 29/09/21.
//

import SwiftUI

struct ArticleDetailView: View, StringInterpolation {
    
    var issueId: Int
    @StateObject var viewModel = ArticleDetailViewModel()
    var articleTitle: String
    @State private var openURL: URL?
    @ObservedObject var dataModel = PDFDownloader(directory: .subDirectory(dir: .articles))

    var body: some View {
        ZStack {
            List() {
                ForEach(viewModel.issues) { issue in
                    Button(action: {
                        let url = viewModel.appFileStorage.buildFullPath(forFileName: self.generateFilePath(firstPath: articleTitle, secondPath: issue.orgArticleFileName), inDirectory: .subDirectory(dir: .articles))
                        self.openURL = url
                        
                        if !viewModel.appFileStorage.exists(file: url) {
                            self.dataModel.startDownload(filePath: issue.orgArticleFileName, folderName: articleTitle, articleURL: issue.newArticleFileName)
                        } else {
                            Logger.log("File exist")
                            self.dataModel.isFinishDownload = true
                        }
                        
                    }) {
                        Text(issue.articleTitle)
                    }

                    
                }
                
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle(articleTitle)
            .allowsHitTesting(!dataModel.isShowProgressView)
            .onAppear {
                viewModel.getIssues(issueId: issueId)
            }            
            .blur(radius: dataModel.isShowProgressView ? 2.0 : 0)
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            if dataModel.isShowProgressView {
                CustomProgressView()
            }
        }
        .alert(item: $viewModel.alertType) { $0.alert }
        .environmentObject(dataModel)
        .sheet(isPresented: $dataModel.isFinishDownload, content: {
            PDFKitView(url: self.$openURL)
        })
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(issueId: 0, articleTitle: "2021-10-09")
    }
}
