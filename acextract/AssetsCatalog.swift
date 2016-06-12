//
//  CatalogReader.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Bartosz Janda
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation

let AssetsCatalogErrorDomain = "AssetsCatalogErrorDomain"

enum AssetsCatalogErrorCodes: Int {
    case OutputDirectoryDoesntExists
    case OutputPathIsNotDirectory
}

class AssetsCatalog {
    // MARK: - Properties
    let filePath: String!
    let fileURL: NSURL!
    let catalog: CUICatalog!
    
    // MARK: - Initialization
    init?(filePath: String) {
        let fp = (filePath as NSString).stringByExpandingTildeInPath
        if NSFileManager.defaultManager().fileExistsAtPath(fp) {
            let url = NSURL(fileURLWithPath: fp)
            self.filePath = fp
            self.fileURL = url
            
            do {
                self.catalog = try CUICatalog(URL: self.fileURL)
            } catch {
                self.catalog = nil
            }
        } else {
            return nil
        }
    }
    
    // MARK: - Methods
    func allImageNames() -> [String] {
        return self.catalog.allImageNames() as? [String] ?? []
    }
    
    func imagesWithName(name: String) -> [CUINamedImage] {
        return self.catalog.imagesWithName(name) as? [CUINamedImage] ?? []
    }
    
    func listContent(verbose: Int) -> String {
        var content = ""
        let names = self.allImageNames()
        for name in names {
            let namedImages = self.imagesWithName(name)
            let imageSet = ImageSet(name: name, namedImages: namedImages)
            content += imageSet.verboseDescription(verbose) + "\n"
        }
        
        return content
    }
    
    func extractContentToDirectoryAtPath(path: String, error: NSErrorPointer) {
        
        let expandedPath = (path as NSString).stringByExpandingTildeInPath
        
        // Check if directory exits.
        var isDirectory: ObjCBool = false
        if !NSFileManager.defaultManager().fileExistsAtPath(expandedPath, isDirectory: &isDirectory) {
            if error != nil {
                error.memory = NSError(domain: AssetsCatalogErrorDomain, code: AssetsCatalogErrorCodes.OutputDirectoryDoesntExists.rawValue, userInfo: nil)
            }
            return
        }
        
        // Check is it is directory.
        if !isDirectory {
            if error != nil {
                error.memory = NSError(domain: AssetsCatalogErrorDomain, code: AssetsCatalogErrorCodes.OutputPathIsNotDirectory.rawValue, userInfo: nil)
            }
            return
        }
        
        // Get image names.
        let names = self.allImageNames()
        for name in names {
            let namedImages = self.imagesWithName(name)
            
            for namedImage in namedImages {
                let filePath = (expandedPath as NSString).stringByAppendingPathComponent(namedImage.ac_imageName)
                var error: NSError?
                print("Extracting: \(namedImage.ac_imageName)", terminator: "")
                let success: Bool
                do {
                    try namedImage.ac_saveAtPath(filePath)
                    success = true
                } catch var error1 as NSError {
                    error = error1
                    success = false
                }
                if success {
                    print(" OK", terminator: "")
                } else {
                    if let e = error {
                        print(" FAILED \(e.localizedDescription)", terminator: "")
                    } else {
                        print(" FAILED", terminator: "")
                    }
                }
            }
        }
    }
}
