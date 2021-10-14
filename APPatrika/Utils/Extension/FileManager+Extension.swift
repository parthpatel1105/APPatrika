//
//  FileManager+Extension.swift
//  APPatrika
//
//  Created by Parth Patel on 19/07/21.
//

import Foundation

enum SaveDocumentItems {
    case article, balPatrika
}

extension FileManager {
    
    private var docDirPath: String {
        let docDir = urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.path
    }
    
    private var articleDirPath: URL {
        var articleDir = urls(for: .documentDirectory, in: .userDomainMask).first!
        articleDir = articleDir.appendingPathComponent("Articles")
        return articleDir
    }
    
    var balPatrikaDirPath: URL {
        var articleDir = urls(for: .documentDirectory, in: .userDomainMask).first!
        articleDir = articleDir.appendingPathComponent("BalPatrika")
        return articleDir
    }
    
    
    func createPDFFilesFolder(itemType: SaveDocumentItems, subFolder: String? = nil) {
        if var pathURL = URL(string: itemType == .article ? self.articleDirPath.path : self.balPatrikaDirPath.path) {
            if let subFolder = subFolder {
                pathURL = pathURL.appendingPathComponent(subFolder)
            }
            if !FileManager.default.fileExists(atPath: pathURL.path) {
                do {
                    try FileManager.default.createDirectory(atPath: pathURL.path, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    Logger.log("Folder create error = \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func saveDocument(itemType: SaveDocumentItems, contents:Data, docName:String, completion: ((Error?) -> Void)) {
        var pathURL =  (itemType == .article ? self.articleDirPath : self.balPatrikaDirPath)
        pathURL = pathURL.appendingPathComponent(docName)
        do {
            try contents.write(to: pathURL, options: .atomic)
            completion(nil)
        } catch {
            Logger.log("Could not save file to directory: \(error.localizedDescription)")
            completion(error)
        }
        
    }
    
    func checkFileExist(itemType: SaveDocumentItems, fileName: String) -> Bool {
        var filePath = itemType == .article ? self.articleDirPath : self.balPatrikaDirPath
        filePath = filePath.appendingPathComponent(fileName)
        
        if self.fileExists(atPath: filePath.path) {
            Logger.log("File exist at path = \(filePath.path)")
            return true
        }
        
        return false
    }
    
    func getSavedFileURL(itemType: SaveDocumentItems, fileName: String) -> URL {
        var filePath = itemType == .article ? self.articleDirPath : self.balPatrikaDirPath
        filePath = filePath.appendingPathComponent(fileName)
        return filePath
    }
    
    func geSavedBalPatrikaFolders() -> [String]? {
        do {
            let directoryContents = try contentsOfDirectory(at: self.balPatrikaDirPath, includingPropertiesForKeys: nil)
            return directoryContents.map { $0.lastPathComponent }
        } catch {
            print(error)
            return nil
        }
    }
    
    func readDocument(docName: String, completion: (String?, Error?) -> Void) {
        let url = urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(docName)
        do {
            completion(try String(contentsOf: url), nil)
        } catch {
            completion(nil, error)
            Logger.log("File read error = \(error.localizedDescription)")
        }
    }
}
