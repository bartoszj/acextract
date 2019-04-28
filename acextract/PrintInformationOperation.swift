//
//  PrintInformationOperation.swift
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

// MARK: - Protocols
// MARK: InformationNameStringConvertible
private protocol InformationNameStringConvertible {
    var informationName: String { get }
}

extension ScaleFactor: InformationNameStringConvertible {
    fileprivate var informationName: String {
        switch self {
        case .scale1x: return "@1x"
        case .scale2x: return "@2x"
        case .scale3x: return "@3x"
        }
    }
}

// MARK: InformationPrintable
private protocol InformationPrintable {
    func printWithLabel(label: String)
}

private extension InformationPrintable where Self: RawRepresentable & IncorrectValueAssertion {
    func printWithLabel(label: String) {
        var text = "    \(label): \(self) (\(self.rawValue))"
        if !self.assertIncorrectValue() {
            text += " INCORRECT!"
        }
        print(text)
    }
}

private extension InformationPrintable where Self: InformationNameStringConvertible & IncorrectValueAssertion {
    func printWithLabel(label: String) {
        var text = "    \(label): \(self.informationName)"
        if !self.assertIncorrectValue() {
            text += " INCORRECT!"
        }
        print(text)
    }
}

extension CUIDeviceIdiom: InformationPrintable { }
extension CUISubtype: InformationPrintable { }
extension CUIUserInterfaceSizeClass: InformationPrintable { }
extension CUIRenderMode: InformationPrintable { }
extension CUIResizingMode: InformationPrintable { }
extension CUIImageType: InformationPrintable { }
extension CUIGraphicalClass: InformationPrintable {
    func printWithLabel(label: String) {
    }
}
extension CUIMemoryClass: InformationPrintable {
    func printWithLabel(label: String) {
    }
}

// MARK: - PrintInformationOperation
struct PrintInformationOperation: Operation {
    let verbose: Verbose

    enum Verbose {
        case name
        case verbose
        case veryVerbose
        case veryVeryVerbose
    }

    func read(catalg: AssetsCatalog) {
        print("Assets catalog: \(catalg.filePath)")
        for imageSet in catalg.imageSets {
            printImageSetData(imageSet: imageSet)
        }
    }

    /**
     Print image set data depending on the verbosity level,

     - parameter imageSet: Image set.
     */
    private func printImageSetData(imageSet: ImageSet) {
        switch verbose {
        case .name:
            print("\(imageSet.name)")
        case .verbose:
            print("\(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq): \(imageSetData(imageSet: imageSet))")
            _ = imageSetData(imageSet: imageSet)
        case .veryVerbose:
            print("\(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq):")
            for namedImage in imageSet.namedImages {
                printNamedImageShortData(namedImage: namedImage)
            }
        case .veryVeryVerbose:
            print("Name: \(escapeSeq+boldSeq)\(imageSet.name)\(escapeSeq+resetSeq)")
            for namedImage in imageSet.namedImages {
                printNamedImageVerboseData(namedImage: namedImage)
            }
        }
    }

    /**
     Returns basic image set data.

     - parameter imageSet: Image set.

     - returns: Image set basic data
     */
    private func imageSetData(imageSet: ImageSet) -> String {
        // Combine information for given idiom.
        // 1. Filter images for given idiom.
        // 2. Map image to "string" representation.
        func deviceInfo(idiom: CUIDeviceIdiom) -> String? {
            let images = imageSet.namedImages.filter({ $0.idiom() == idiom }).map { image -> String in
                let pdf = image.acIsPDF ? "PDF" : ""
                return "\(pdf+image.subtype().name+image.acScale.informationName+image.acSizeClassString)"
            }
            guard images.count > 0 else {
                return nil
            }
            return "\(idiom): \(images.joined(separator: ","))"
        }

        // Create output for every idiom.
        let output = CUIDeviceIdiom.allValues.map { deviceInfo(idiom: $0) }.compactMap({ $0 })
        return output.joined(separator: ", ")
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
        func printProperty(label: String, value: Any?) {
            if let value = value {
                print("    \(label): \(value)")
            } else {
                print("    \(label): \(value ?? "")")
            }
        }

        print("  \(namedImage.acImageName):")
        //
        // CUINamedLookup
        printProperty(label: "name", value: namedImage.name)
        printProperty(label: "renditionName", value: namedImage.renditionName())

        // renditionKey() -> CUIRenditionKey
//        printProperty("rendition key", value: namedImage.renditionKey())
        namedImage.renditionKey().themeGraphicsClass().printWithLabel(label: "rendition key graphical class")
        namedImage.renditionKey().themeMemoryClass().printWithLabel(label: "rendition key memory class")

        // _rendition() -> CUIThemeRendition
        printProperty(label: "rendition name", value: namedImage._rendition().name())
        namedImage._rendition().type().printWithLabel(label: "rendition type")
        printProperty(label: "rendition subtype", value: namedImage._rendition().subtype())
        printProperty(label: "rendition UTI type", value: namedImage._rendition().utiType())
        printProperty(label: "rendition data", value: namedImage._rendition().data())
        printProperty(label: "rendition pdf", value: namedImage._rendition().pdfDocument())
        printProperty(label: "rendition image", value: namedImage._rendition().unslicedImage())

//        printProperty("rendition slice information", value: namedImage._rendition().sliceInformation()?.description())
        printProperty(label: "rendition slice edgeInsets", value: namedImage._rendition().sliceInformation()?.edgeInsets)
        printProperty(label: "rendition slice destinationRect", value: namedImage._rendition().sliceInformation()?.destinationRect)
        namedImage._rendition().sliceInformation()?.renditionType.printWithLabel(label: "rendition slice renditionType")
        printProperty(label: "rendition slice _bottomRightCapSize", value: namedImage._rendition().sliceInformation()?._bottomRightCapSize())
        printProperty(label: "rendition slice _topLeftCapSize", value: namedImage._rendition().sliceInformation()?._topLeftCapSize())

        //
        // CUINamedImage
        namedImage.imageType.printWithLabel(label: "imageType")
        namedImage.idiom().printWithLabel(label: "idiom")
        namedImage.subtype().printWithLabel(label: "subtype")
        printProperty(label: "scale", value: namedImage.acScale.informationName)
        namedImage.sizeClassHorizontal().printWithLabel(label: "size vlass horizontal")
        namedImage.sizeClassVertical().printWithLabel(label: "size vlass vertical")
        namedImage.graphicsClass().printWithLabel(label: "graphics class")
        namedImage.memoryClass().printWithLabel(label: "memory class")
        printProperty(label: "opacity", value: namedImage.opacity)
        printProperty(label: "size", value: namedImage.size)
        printProperty(label: "blend mode", value: namedImage.blendMode)
        namedImage.resizingMode.printWithLabel(label: "resizing mode")
        printProperty(label: "is template", value: namedImage.isTemplate)
        printProperty(label: "vector based", value: namedImage.isVectorBased)
        printProperty(label: "hasAlignmentInformation", value: namedImage.hasAlignmentInformation)
        printProperty(label: "hasSliceInformation", value: namedImage.hasSliceInformation)
        namedImage.templateRenderingMode.printWithLabel(label: "template rendering mode")
        printProperty(label: "edge insets", value: namedImage.edgeInsets)
        printProperty(label: "alignment edge insets", value: namedImage.alignmentEdgeInsets)
        printProperty(label: "exifOrientation", value: namedImage.exifOrientation)
        printProperty(label: "image", value: namedImage.image)

        // baseKey -> CUIRenditionKey
//        printProperty(label: "base key", value: namedImage.baseKey())
        namedImage.baseKey().themeGraphicsClass().printWithLabel(label: "base key graphical class")
        namedImage.baseKey().themeMemoryClass().printWithLabel(label: "base key memory class")
    }
}
