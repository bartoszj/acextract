//
//  CatalogReader.swift
//  acextract
//
//  Created by Bartosz Janda on 14.12.2014.
//  Copyright (c) 2014 Bartosz Janda. All rights reserved.
//

import Foundation

class CatalogReader {
    // MARK: - Properties
    let filePath: String!
    let fileURL: NSURL!
    let catalog: CUICatalog!
    
    // MARK: - Initialization
    init?(filePath: String) {
        let fp = filePath.stringByExpandingTildeInPath
        if NSFileManager.defaultManager().fileExistsAtPath(fp) {
            if let url = NSURL(fileURLWithPath: fp) {
                self.filePath = fp
                self.fileURL = url
                
                let error = NSErrorPointer()
                self.catalog = CUICatalog(URL: self.fileURL, error: error)
            } else {
                return nil
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
            println(imageSet.verboseDescription(verbose))
        }
        
        return content
    }
    
    func extractContentToDirectoryAtPath(path: String) {
        
    }
}
