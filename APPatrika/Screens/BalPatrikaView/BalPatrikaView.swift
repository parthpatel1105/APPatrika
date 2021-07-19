//
//  BalPatrikaView.swift
//  APPatrika
//
//  Created by Parth Patel on 12/07/21.
//

import SwiftUI

struct BalPatrikaView: View {
    
    @StateObject var viewModel = BalPatrikaViewModel()
    @ObservedObject var dataModel = PDFDownloader()
    var fileManager = FileManager()
    
    var body: some View {
        ZStack {
            NavigationView {
                List(viewModel.balPatrikas) { balPatrika in
                    BalPatrikaListCell(balPatrika: balPatrika)
                        .onTapGesture {
                            if !fileManager.checkFileExist(itemType: .balPatrika, fileName: balPatrika.bPFile) {
                                self.dataModel.startDownload(filePath: balPatrika.bPFile)
                            } else {
                                Logger.log("File exist")
                            }
                            
                        }
                }
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
    }
}

struct BalPatrikaView_Previews: PreviewProvider {
    static var previews: some View {
        BalPatrikaView()
    }
}
