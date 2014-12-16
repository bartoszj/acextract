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
            
//            switch verbose {
//            case 0:
//                content = "\(name)\n"
//            case 1:
//                
//                for namedImage in namedImages {
////                    println(namedImage)
//                    println("name: \(namedImage.name)")
//                    println("scale: \(namedImage.scale)")
//                    println("opacity: \(namedImage.opacity)")
//                    println("size: \(namedImage.size)")
//                    println("blendMode: \(namedImage.blendMode)")
//                    println("resizingMode: \(namedImage.resizingMode.rawValue)")
//                    println("vector: \(namedImage.isVectorBased)")
//                    println("hasSliceInformation: \(namedImage.hasSliceInformation)")
//                    println("template: \(namedImage.isTemplate)")
//                    println("template mode: \(namedImage.templateRenderingMode.rawValue)")
//                    println("image type: \(namedImage.imageType.rawValue)")
//                    println("subtype: \(namedImage.subtype().rawValue)")
//                    println("alignmentEdgeInsets: \(namedImage.alignmentEdgeInsets.top), \(namedImage.alignmentEdgeInsets.left), \(namedImage.alignmentEdgeInsets.bottom), \(namedImage.alignmentEdgeInsets.right)")
//                    println("alignmentRect: \(namedImage.alignmentRect().origin.x), \(namedImage.alignmentRect().origin.y), \(namedImage.alignmentRect().size.width), \(namedImage.alignmentRect().size.height)")
//                    println("edge insets: \(namedImage.edgeInsets.top), \(namedImage.edgeInsets.left), \(namedImage.edgeInsets.bottom), \(namedImage.edgeInsets.right)")
//                    println("orientation: \(namedImage.exifOrientation)")
//                    println("idiom: \(namedImage.idiom().rawValue)")
//                    println("sizeClassVertical: \(namedImage.sizeClassVertical().rawValue)")
//                    println("sizeClassHorizontal: \(namedImage.sizeClassHorizontal().rawValue)")
//                }
//                break
//            default:
//                break
//            }
//            
//            
//            println(name)
        }
        
        return content
    }
    
    func extractContentToDirectoryAtPath(path: String) {
        
    }
}
