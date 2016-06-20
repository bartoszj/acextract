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

private protocol InformationNameStringConvertible {
    var informationName: String { get }
}

extension Double: InformationNameStringConvertible {
    private var informationName: String {
        switch self {
        case 1.0: return "@1x"
        case 2.0: return "@2x"
        case 3.0: return "@3x"
        default: return "other"
        }
    }
}

private let escapeSeq = "\u{1b}"
private let boldSeq = "[1m"
private let resetSeq = "[0m"
struct PrintInformationOperation: Operation {
    let verbose: Verbose

    enum Verbose {
        case Name
        case Verbose
        case VeryVerbose
        case VeryVeryVerbose
    }

    func read(catalg: AssetsCatalog) {
        print("Assets catalog: \(catalg.filePath)")
        for imageSet in catalg.imageSets {
            printImageSetData(imageSet)
        }
    }

    /**
     Print image set data depending on the verbosity level,

     - parameter imageSet: Image set.
     */
    private func printImageSetData(imageSet: ImageSet) {
        switch verbose {
        case .Name:
            print("\(imageSet.name)")
        case .Verbose:
            print("\(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq): \(imageSetData(imageSet))")
            imageSetData(imageSet)
        case .VeryVerbose:
            print("\(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq):")
            for namedImage in imageSet.namedImages {
                printNamedImageShortData(namedImage)
            }
        case .VeryVeryVerbose:
            print("Name: \(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq)")
            for namedImage in imageSet.namedImages {
                printNamedImageVerboseData(namedImage)
            }
        }
    }

    /**
     Returns basic image set data.

     - parameter imageSet: Image set.

     - returns: Image set basic data
     */
    private func imageSetData(imageSet: ImageSet) -> String {
        // Filter images by idiom.
        func imageFilter(idiom: CUIDeviceIdiom) -> (CUINamedImage) -> (Bool) {
            return { $0.idiom() == idiom }
        }

        // Map image to "short" description.
        func imageMap(image: CUINamedImage) -> String {
            let pdf = image.acIsPDF ? "PDF" : ""
            return "\(pdf+image.subtype().name+image.scale.informationName+image.acSizeClassString)"
        }

        // Combine information for given idiom.
        func deviceInfo(idiom: CUIDeviceIdiom) -> String? {
            let images = imageSet.namedImages.filter(imageFilter(idiom)).map(imageMap)
            guard images.count > 0 else {
                return nil
            }
            return "\(idiom): \(images.joinWithSeparator(","))"
        }

        // Create output.
        let output = CUIDeviceIdiom.allValues.map { deviceInfo($0) }.flatMap({ $0 })
        return output.joinWithSeparator(", ")
    }

    /**
     Print named image name.

     - parameter namedImage: Named image.
     */
    private func printNamedImageShortData(namedImage: CUINamedImage) {
        print("  \(namedImage.acImageName)")
    }

    /**
     Print named image verbose logs.

     - parameter namedImage: Named image.
     */
    private func printNamedImageVerboseData(namedImage: CUINamedImage) {
        func printProperty1(label: String, value: Any?) {
            if let value = value {
                print("    \(label): \(value)")
            } else {
                print("    \(label): \(value)")
            }
        }

        func printProperty2<T: protocol<RawRepresentable, IncorrectValueAssertion>>(label: String, rawValue: T) {
            var text = "    \(label): \(rawValue) (\(rawValue.rawValue))"
            if !rawValue.assertIncorrectValue() {
                text += " INCORRECT!"
            }
            print(text)
        }

        func printProperty3(label: String, rawValue: IncorrectValueAssertion) {
            var text = "    \(label): \(rawValue))"
            if !rawValue.assertIncorrectValue() {
                text += " INCORRECT!"
            }
            print(text)
        }

        print("  \(namedImage.acImageName):")
        printProperty2("imageType", rawValue: namedImage.imageType)
        printProperty2("idiom", rawValue: namedImage.idiom())
        printProperty2("subtype", rawValue: namedImage.subtype())
        printProperty3("scale", rawValue: namedImage.scale)
        printProperty2("size vlass horizontal", rawValue: namedImage.sizeClassHorizontal())
        printProperty2("size vlass vertical", rawValue: namedImage.sizeClassVertical())
        printProperty1("opacity", value: namedImage.opacity)
        printProperty1("size", value: namedImage.size)
        printProperty1("blend mode", value: namedImage.blendMode)
        printProperty2("resizing mode", rawValue: namedImage.resizingMode)
        printProperty1("is template", value: namedImage.isTemplate)
        printProperty1("vector based", value: namedImage.isVectorBased)
        printProperty2("template rendering mode", rawValue: namedImage.templateRenderingMode)
        printProperty1("edge insets", value: namedImage.edgeInsets)
        printProperty1("alignment edge insets", value: namedImage.alignmentEdgeInsets)
        printProperty1("exifOrientation", value: namedImage.exifOrientation)
        printProperty1("rendition name", value: namedImage._rendition().name())
        printProperty1("rendition data", value: namedImage._rendition().data())
        printProperty1("rendition pdf", value: namedImage._rendition().pdfDocument())
        printProperty1("rendition image", value: namedImage._rendition().unslicedImage())
        printProperty1("rendition UTI type", value: namedImage._rendition().utiType())
        printProperty1("rendition type", value: namedImage._rendition().type())
        printProperty1("rendition subtype", value: namedImage._rendition().subtype())
    }
}

struct ExtractOperation: Operation {
    let outputPath: String

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
