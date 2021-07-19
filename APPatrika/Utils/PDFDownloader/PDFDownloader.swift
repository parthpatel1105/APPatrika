//
//  PDFDownloader.swift
//  APPatrika
//
//  Created by Parth Patel on 18/07/21.
//

import UIKit

class PDFDownloader: NSObject , ObservableObject {
    let fileManager = FileManager()
    @Published var progress = Float(0)
    @Published var progressText = "0%"
    @Published var isShowProgressView: Bool = false
    
    var downloadTask: URLSessionDownloadTask?
}

extension PDFDownloader {
    
    var configuration: EnvironmentConfiguration {
        return EnvironmentConfiguration.init()
    }
    
    var downloadsSession : URLSession {
        get {
            let config = URLSessionConfiguration.background(withIdentifier: "background")
            let queue = OperationQueue()
            return URLSession(configuration: config, delegate: self, delegateQueue: queue)
        }
    }
    
    func startDownload(filePath: String) {
        let urlString = configuration.balPatrikaDownloadURL + filePath
        guard let url = URL(string: urlString) else {return}
        self.downloadTask = downloadsSession.downloadTask(with: url)
        self.downloadTask?.taskDescription = filePath
        self.downloadTask?.resume()
        self.isShowProgressView = true
    }
}

extension PDFDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            if let description = downloadTask.taskDescription {
                fileManager.saveDocument(itemType: .balPatrika, contents: data, docName: description) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            //show alert
                            Logger.log("Error = \(error.localizedDescription)")
                        } else {
                            //open pdf
                        }
                        self.isShowProgressView = false
                    }
                    
                }
            }
        }
    }
    
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            Logger.log("self.progress = \(self.progress)")
            self.progressText =  String(format: "%.f%%", self.progress * 100)
        }
    }
    
}

