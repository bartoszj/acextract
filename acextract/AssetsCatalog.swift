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

enum AssetsCatalogError: ErrorType {
    case FileDoesntExists
    case OutputDirectoryDoesntExists
    case OutputPathIsNotDirectory
}

class AssetsCatalog {
    // MARK: Properties
    let filePath: String
    let fileURL: NSURL
    let catalog: CUICatalog

    // MARK: Initialization
    init(path: String) throws {
        let fp = (path as NSString).stringByExpandingTildeInPath
        if NSFileManager.defaultManager().fileExistsAtPath(fp) {
            let url = NSURL(fileURLWithPath: fp)
            self.filePath = fp
            self.fileURL = url

            do {
                self.catalog = try CUICatalog(URL: self.fileURL)
            } catch {
                throw AssetsCatalogError.FileDoesntExists
            }
        } else {
            throw AssetsCatalogError.FileDoesntExists
        }
    }

    // MARK: Methods
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

    func extractContentToDirectoryAtPath(path: String) throws {

        let expandedPath = (path as NSString).stringByExpandingTildeInPath

        // Check if directory exits.
        var isDirectory: ObjCBool = false
        if !NSFileManager.defaultManager().fileExistsAtPath(expandedPath, isDirectory: &isDirectory) {
            throw AssetsCatalogError.OutputDirectoryDoesntExists
        }

        // Check is it is directory.
        if !isDirectory {
            throw AssetsCatalogError.OutputPathIsNotDirectory
        }

        // Get image names.
        let names = self.allImageNames()
        for name in names {
            let namedImages = self.imagesWithName(name)

            for namedImage in namedImages {
                let filePath = (expandedPath as NSString).stringByAppendingPathComponent(namedImage.ac_imageName)
                print("Extracting: \(namedImage.ac_imageName)", terminator: "")
                let success: Bool
                do {
                    try namedImage.ac_saveAtPath(filePath)
                    success = true
                } catch {
                    success = false
                }
                if success {
                    print(" OK", terminator: "")
                } else {
                    print(" FAILED", terminator: "")
                }
            }
        }
    }
}
