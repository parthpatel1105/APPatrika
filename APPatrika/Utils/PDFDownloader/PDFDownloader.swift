//
//  PDFDownloader.swift
//  APPatrika
//
//  Created by Parth Patel on 18/07/21.
//

import UIKit
import SwiftUI

class PDFDownloader: NSObject , ObservableObject {
    let storage = AppFileStorage()
    @Published var progress = Float(0)
    @Published var progressText = "0%"
    @Published var isShowProgressView: Bool = false
    @Published var isFinishDownload: Bool = false
    private var filePath: String?
    var downloadTask: URLSessionDownloadTask?
    var directory: AppDirectories
    init(directory: AppDirectories) {
        self.directory = directory
    }
}


extension PDFDownloader {
    
    var configuration: EnvironmentConfiguration {
        return EnvironmentConfiguration.init()
    }
    
    var downloadsSession : URLSession {
        get {
            //let config = URLSessionConfiguration.background(withIdentifier: "background")
            let config = URLSessionConfiguration.background(withIdentifier: self.filePath!)
            let queue = OperationQueue()
            return URLSession(configuration: config, delegate: self, delegateQueue: queue)
        }
    }
    
    func startDownload(filePath: String, folderName: String, articleURL: String = "") {
        storage.createFolder(forFolderName: folderName, to: directory)
        self.filePath = filePath
        var urlString = ""
        
        if case .subDirectory(.balPatrika) = self.directory {
            urlString = configuration.balPatrikaDownloadURL + filePath
        } else {
            urlString = articleURL
        }
        guard let url = URL(string: urlString) else {return}
        self.downloadTask = downloadsSession.downloadTask(with: url)
        self.downloadTask?.taskDescription = "\(folderName)/\(filePath)"
        self.downloadTask?.resume()
        self.isShowProgressView = true
    }
}
//http://168.63.234.13/dbphp/patrika_get_article_by_issueid.php?issueid=25071
//http://168.63.234.13/dbphp/patrika_get_article_by_issueid.php?issueid=25072
extension PDFDownloader: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let data = try? Data(contentsOf: location) {
            if let description = downloadTask.taskDescription {
                storage.writePDFFile(to: self.directory, for: description, contents: data) { error in
                    DispatchQueue.main.async {
                        if let error = error {
                            //show alert
                            Logger.log("Error = \(error.localizedDescription)")
                        } else {
                            //open pdf
                        }
                        self.isShowProgressView = false
                        self.isFinishDownload = true
                        self.progressText = "0%"
                        self.progress = Float(0)
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

