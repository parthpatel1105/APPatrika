//
//  BalPatrikaView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct BalPatrikaView: View, StringInterpolation {
    
    @StateObject var viewModel = BalPatrikaViewModel()
    @ObservedObject var dataModel = PDFDownloader(directory: .subDirectory(dir: .balPatrika))
    @State private var openURL: URL?
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.balPatrikas, content: row(balPatrika:))
//                    ForEach(viewModel.balPatrikas) { balPatrika in
//                        Button(action: {
//                            let url = viewModel.appFileStorage.buildFullPath(forFileName: self.generateFilePath(firstPath: balPatrika.bPTitle, secondPath: balPatrika.bPFile), inDirectory: .subDirectory(dir: .balPatrika))
//                            self.openURL = url
//                            print("Open URL = \(String(describing: self.openURL))")
//
//                            if !viewModel.appFileStorage.exists(file: url) {
//                                self.dataModel.startDownload(filePath: balPatrika.bPFile, folderName: balPatrika.bPTitle)
//                            } else {
//                                Logger.log("File exist")
//                                dataModel.isFinishDownload = true
//                            }
//
//                        }) {
//                            BalPatrikaListCell(balPatrika: balPatrika)
//                        }
//                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("BalPatrika")
                .navigationBarItems(
                    trailing:
                        Button(action: {
                            viewModel.getBalPatrika()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                )
            }
            .allowsHitTesting(!dataModel.isShowProgressView)
            .onAppear {
                viewModel.getBalPatrika()
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
    
    @ViewBuilder
    func row(balPatrika: BalPatrikaModel) -> some View {
        Button(action: {
            let url = viewModel.appFileStorage.buildFullPath(forFileName: self.generateFilePath(firstPath: balPatrika.bPTitle, secondPath: balPatrika.bPFile), inDirectory: .subDirectory(dir: .balPatrika))
            self.openURL = url
            print("Open URL = \(String(describing: self.openURL))")

            if !viewModel.appFileStorage.exists(file: url) {
                self.dataModel.startDownload(filePath: balPatrika.bPFile, folderName: balPatrika.bPTitle)
            } else {
                Logger.log("File exist")
                dataModel.isFinishDownload = true
            }

        }) {
            BalPatrikaListCell(balPatrika: balPatrika)
        }

    }
   
}

struct BalPatrikaView_Previews: PreviewProvider {
    static var previews: some View {
        BalPatrikaView()
    }
}
