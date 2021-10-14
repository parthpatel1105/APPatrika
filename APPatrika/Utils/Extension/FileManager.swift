//
//  FileManager.swift
//  APPatrika
//
//  Created by Parth Patel on 25/08/21.
//

import Foundation

enum AppDirectories {
    case Documents
    case Inbox
    case Library
    case Temp
    case subDirectory(dir: SubDirectories)
    
    var dirIdentifier: String {
        switch self {
        case .Documents:
            return "Documents"
        case .Inbox:
            return "Inbox"
        case .Library:
            return "Library"
        case .Temp:
            return "tmp"
        case .subDirectory:
            return ""
        }
    }
}

enum SubDirectories: CaseIterable {
    case articles
    case balPatrika
    
    var dirIdentifier: String {
        switch self {
        case .articles:
            return "Articles"
        case .balPatrika:
            return "BalPatrika"
        }
    }
}

protocol AppDirectoryNames {
    func documentsDirectoryURL() -> URL
    func inboxDirectoryURL() -> URL
    func libraryDirectoryURL() -> URL
    func tempDirectoryURL() -> URL
    func subDirectoryURL(subDirectory: SubDirectories) -> URL
    func getURL(for directory: AppDirectories) -> URL
    func buildFullPath(forFileName name: String, inDirectory directory: AppDirectories) -> URL
}

extension AppDirectoryNames {
    func documentsDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        //return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func inboxDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(AppDirectories.Inbox.dirIdentifier) // "Inbox")
    }
    
    func libraryDirectoryURL() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: .userDomainMask).first!
    }
    
    func tempDirectoryURL() -> URL {
        return FileManager.default.temporaryDirectory
        //urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(AppDirectories.Temp.rawValue) //"tmp")
    }
    
    func subDirectoryURL(subDirectory: SubDirectories) -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(subDirectory.dirIdentifier)
    }
    
    func getURL(for directory: AppDirectories) -> URL {
        switch directory {
        case .Documents:
            return documentsDirectoryURL()
        case .Inbox:
            return inboxDirectoryURL()
        case .Library:
            return libraryDirectoryURL()
        case .Temp:
            return tempDirectoryURL()
        case .subDirectory(let dirName):
            return documentsDirectoryURL().appendingPathComponent(dirName.dirIdentifier)
        }
    }
    
    func buildFullPath(forFileName name: String, inDirectory directory: AppDirectories) -> URL {
        return getURL(for: directory).appendingPathComponent(name)
    }
}

protocol AppFileStatusChecking {
    func isWritable(file at: URL) -> Bool
    func isReadable(file at: URL) -> Bool
    func exists(file at: URL) -> Bool
}

extension AppFileStatusChecking {
    func isWritable(file at: URL) -> Bool {
        if FileManager.default.isWritableFile(atPath: at.path) {
            Logger.log("Is Writable file at: \(at.path)")
            return true
        }
        else {
            Logger.log("Error : Is Writable file at: \(at.path)")
            return false
        }
    }
    
    func isReadable(file at: URL) -> Bool {
        if FileManager.default.isReadableFile(atPath: at.path) {
            Logger.log("Is Readable file at: \(at.path)")
            return true
        }
        else {
            Logger.log("Error: Is Readable file at: \(at.path)")
            return false
        }
    }
    
    func exists(file at: URL) -> Bool {
        if FileManager.default.fileExists(atPath: at.path) {
            Logger.log("File available at path: \(at.path)")
            return true
        }
        else {
            Logger.log("File xxxxx not available at path: \(at.path)")
            return false
        }
    }
}


protocol AppFileSystemMetaData {
    func list(directory at: URL) -> Bool
    func attributes(ofFile atFullPath: URL) -> [FileAttributeKey : Any]
    func listDirectories(directory at: URL) -> [URL]?
}
 
extension AppFileSystemMetaData {
    
    func list(directory at: URL) -> Bool {
        let listing = try! FileManager.default.contentsOfDirectory(atPath: at.path)
        
        if listing.count > 0 {
            Logger.log("\n----------------------------")
            Logger.log("LISTING: \(at.path)")
            Logger.log("")
            
            for file in listing {
                Logger.log("File: \(file.debugDescription)")
            }
            Logger.log("")
            Logger.log("----------------------------\n")
            
            return true
        }
        else {
            return false
        }
    }
    
    func listDirectories(directory at: URL) -> [URL]? {
        let directoryContents =
            try! FileManager.default.contentsOfDirectory(at: at,
                                                         includingPropertiesForKeys: nil,
                                                         options: [.skipsHiddenFiles]
            )
//        let fileURL: URL = at.appendingPathComponent(directoryContents[0].lastPathComponent)
//        let attributes =
//            try! FileManager.default.attributesOfItem(atPath: fileURL.path)
//        print("Create date = \(String(describing: attributes[.ownerAccountID]))")

//        let dict = directoryContents.reduce(into: [[URL: String]]()) {
//            $0[$1] = $1.lastPathComponent
//        }
        print("Dict = \(directoryContents)")
        return directoryContents//directoryContents.map { $0.lastPathComponent }
    }
    
    func attributes(ofFile atFullPath: URL) -> [FileAttributeKey : Any] {
        return try! FileManager.default.attributesOfItem(atPath: atFullPath.path)
    }
}

protocol AppFileManipulation : AppDirectoryNames {
    func writePDFFile(to path: AppDirectories, for fileName: String, contents: Data, completion: ((Error?) -> Void))
    func writeFile(containing: String, to path: AppDirectories, withName name: String) -> Bool
    func readFile(at path: AppDirectories, withName name: String) -> String
    func deleteFile(at path: AppDirectories, withName name: String) -> Bool
    func deleteFile(at url: URL) -> Bool?
    func renameFile(at path: AppDirectories, with oldName: String, to newName: String) -> Bool
    func moveFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool
    func copyFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool
    func changeFileExtension(withName name: String, inDirectory: AppDirectories, toNewExtension newExtension: String) -> Bool
    func createFolder(forFolderName name: String?, to path: AppDirectories)

}

extension AppFileManipulation {
    
    func writePDFFile(to path: AppDirectories, for fileName: String, contents: Data, completion: ((Error?) -> Void)) {
        let url = buildFullPath(forFileName: fileName, inDirectory: path)
        do {
            try contents.write(to: url, options: .atomic)
            completion(nil)
        } catch {
            Logger.log("Could not save file to directory: \(error.localizedDescription)")
            completion(error)
        }
    }
    
    func writeFile(containing: String, to path: AppDirectories, withName name: String) -> Bool {
        let filePath = getURL(for: path).path + "/" + name
        let rawData: Data? = containing.data(using: .utf8)
        return FileManager.default.createFile(atPath: filePath, contents: rawData, attributes: nil)
    }
    
    func readFile(at path: AppDirectories, withName name: String) -> String {
        let filePath = getURL(for: path).path + "/" + name
        let fileContents = FileManager.default.contents(atPath: filePath)
        let fileContentsAsString = String(bytes: fileContents!, encoding: .utf8)
        print(fileContentsAsString!)
        return fileContentsAsString!
    }
    
    func deleteFile(at path: AppDirectories, withName name: String) -> Bool {
        let filePath = buildFullPath(forFileName: name, inDirectory: path)
        try! FileManager.default.removeItem(at: filePath)
        return true
    }
    
    func deleteFile(at url: URL) -> Bool? {
        try? FileManager.default.removeItem(at: url)
        return true
    }
    
    func renameFile(at path: AppDirectories, with oldName: String, to newName: String) -> Bool {
        let oldPath = getURL(for: path).appendingPathComponent(oldName)
        let newPath = getURL(for: path).appendingPathComponent(newName)
        try! FileManager.default.moveItem(at: oldPath, to: newPath)
        
        // highlights the limitations of using return values
        return true
    }
    
    func moveFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool {
        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: name, inDirectory: directory)
        // warning: constant 'success' inferred to have type '()', which may be unexpected
        // let success =
        try! FileManager.default.moveItem(at: originURL, to: destinationURL)
        return true
    }
    
    func copyFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool {
        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: name+"1", inDirectory: directory)
        try! FileManager.default.copyItem(at: originURL, to: destinationURL)
        return true
    }
    
    func changeFileExtension(withName name: String, inDirectory: AppDirectories, toNewExtension newExtension: String) -> Bool {
        var newFileName = NSString(string:name)
        newFileName = newFileName.deletingPathExtension as NSString
        newFileName = (newFileName.appendingPathExtension(newExtension) as NSString?)!
        let finalFileName:String =  String(newFileName)
        
        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: finalFileName, inDirectory: inDirectory)
        
        try! FileManager.default.moveItem(at: originURL, to: destinationURL)
        
        return true
    }
    
    func createFolder(forFolderName name: String? = nil, to path: AppDirectories) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-mm-dd HH:mm"
        let folder: URL!
        if let name = name {
            folder = buildFullPath(forFileName: name, inDirectory: path)
        } else {
            folder = getURL(for: path)
        }
        
        if !FileManager.default.fileExists(atPath: folder.path) {
            do {
                try FileManager.default.createDirectory(atPath: folder.path,
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            } catch {
                Logger.log("Folder create error = \(error.localizedDescription)")
            }
        }
    }
}


struct AppFileStorage : AppFileManipulation, AppFileStatusChecking, AppFileSystemMetaData {
//    let fileName: String
//
//    init(fileName: String) {
//        self.fileName = fileName
//    }
  
    func deleteTempFile(fileName: String) {
        _ = deleteFile(at: .Temp, withName: fileName)
    }
    
//    func checkFileAvailable(fileName: String, subdirectory: SubDirectories) -> Bool {
//        let url = buildFullPath(forFileName: fileName, inDirectory: .subDirectory(dir: subdirectory))
//        return exists(file: url)
//    }
}
