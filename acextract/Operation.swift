//
//  Operation.swift
//
//  The MIT License (MIT)
//
//  Copyright (c) 2016 Bartosz Janda
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

protocol Operation {
    func read(catalg: AssetsCatalog) -> Void
}

struct CompoundOperation: Operation {
    let operations: [Operation]

    func read(catalg: AssetsCatalog) {
        for operation in operations {
            operation.read(catalg)
        }
    }
}

private let escapeSeq = "\u{1b}"
struct PrintInformationOperation: Operation {
    let verbose: Verbose

    enum Verbose {
        case Name
        case Verbose
        case VeryVerbose
    }

    func read(catalg: AssetsCatalog) {
        print("Assets catalog: \(catalg.filePath)")
        for imageSet in catalg.imageSets {
            printImageData(imageSet)
        }
    }

    private func printImageData(imageSet: ImageSet) {
        switch verbose {
        case .Name:
            print("Name: \(escapeSeq)[1m\(imageSet.name)\(escapeSeq)[0m")
        case .Verbose:
            print("Name: \(escapeSeq)[1m\(imageSet.name)\(escapeSeq)[0m: (\(imageSet.shortDesription))")
        case .VeryVerbose:
            print("Name: \(escapeSeq)[1m\(imageSet.name)\(escapeSeq)[0m")
            for namedImage in imageSet.namedImages {
                printNameImageData(namedImage)
            }
        }
    }

    private func printNameImageData(namedImage: CUINamedImage) {
        print("  \(namedImage.acImageName):")

        // Image type
        var imageType = "    imageType: \(namedImage.imageType) (\(namedImage.imageType.rawValue))"
        if !namedImage.imageType.assertIncorrectValue() {
            imageType += " INCORRECT!"
        }
        print(imageType)

        // Idiom
        var idiom = "    idiom: \(namedImage.idiom()) (\(namedImage.idiom().rawValue))"
        if !namedImage.idiom().assertIncorrectValue() {
            idiom += " INCORRECT!"
        }
        print(idiom)

        // Subtype
        var subtype = "    subtype: \(namedImage.subtype()) (\(namedImage.subtype().rawValue))"
        if !namedImage.subtype().assertIncorrectValue() {
            subtype += " INCORRECT!"
        }
        print(subtype)

        // Scale
        var scale = "    scale: \(namedImage.scale)"
        if !namedImage.scale.assertIncorrectValue() {
            scale += " INCORRECT!"
        }
        print(scale)

        // Size class
        var sizeClassHorizontal = "    size vlass horizontal: \(namedImage.sizeClassHorizontal()) (\(namedImage.sizeClassHorizontal().rawValue))"
        if !namedImage.sizeClassHorizontal().assertIncorrectValue() {
            sizeClassHorizontal += " INCORRECT!"
        }
        print(sizeClassHorizontal)

        var sizeClassVertical = "    size vlass vertical: \(namedImage.sizeClassVertical()) (\(namedImage.sizeClassVertical().rawValue))"
        if !namedImage.sizeClassVertical().assertIncorrectValue() {
            sizeClassVertical += " INCORRECT!"
        }
        print(sizeClassVertical)

        print("    opacity: \(namedImage.opacity)")
        print("    size: \(namedImage.size)")
        print("    blend mode: \(namedImage.blendMode)")

        // Resizing mode
        var resizingMode = "    resizing mode: \(namedImage.resizingMode) (\(namedImage.resizingMode.rawValue))"
        if !namedImage.resizingMode.assertIncorrectValue() {
            resizingMode += " INCORRECT!"
        }
        print(resizingMode)

        print("    is template: \(namedImage.isTemplate)")
        print("    vector based: \(namedImage.isVectorBased)")

        // Rendering mode
        var templateRenderingMode = "    template rendering mode: \(namedImage.templateRenderingMode) (\(namedImage.templateRenderingMode.rawValue))"
        if !namedImage.templateRenderingMode.assertIncorrectValue() {
            templateRenderingMode += " INCORRECT!"
        }
        print(templateRenderingMode)
        print("    edge insets: \(namedImage.edgeInsets)")
        print("    alignment edge insets: \(namedImage.alignmentEdgeInsets)")
//         print("    alignment rect: \(image.alignmentRect())")
        print("    exifOrientation: \(namedImage.exifOrientation)")
        print("    rendition name: \(namedImage._rendition().name())")
        print("    rendition data: \(namedImage._rendition().data())")
        print("    rendition pdf: \(namedImage._rendition().pdfDocument())")
        print("    rendition image: \(namedImage._rendition().unslicedImage())")
        print("    rendition UTI type: \(namedImage._rendition().utiType())")
        print("    rendition type: \(namedImage._rendition().type())")
        print("    rendition subtype: \(namedImage._rendition().subtype())")
    }
}

struct ExtractOperation: Operation {
    let output: String

    func read(catalg: AssetsCatalog) {

    }

    // private func extractContentToDirectoryAtPath(path: String) throws {
    //
    // let expandedPath = (path as NSString).stringByExpandingTildeInPath
    //
    // // Check if directory exits.
    // var isDirectory: ObjCBool = false
    // if !NSFileManager.defaultManager().fileExistsAtPath(expandedPath, isDirectory: &isDirectory) {
    // throw AssetsCatalogError.OutputDirectoryDoesntExists
    // }
    //
    // // Check is it is directory.
    // if !isDirectory {
    // throw AssetsCatalogError.OutputPathIsNotDirectory
    // }
    //
    // // Get image names.
    // let names = self.allImageNames()
    // for name in names {
    // let namedImages = self.imagesWithName(name)
    //
    // for namedImage in namedImages {
    // let filePath = (expandedPath as NSString).stringByAppendingPathComponent(namedImage.ac_imageName)
    // print("Extracting: \(namedImage.ac_imageName)", terminator: "")
    // let success: Bool
    // do {
    // try namedImage.ac_saveAtPath(filePath)
    // success = true
    // } catch {
    // success = false
    // }
    // if success {
    // print(" OK", terminator: "")
    // } else {
    // print(" FAILED", terminator: "")
    // }
    // }
    // }
    // }
}
