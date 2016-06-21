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
    private var informationName: String {
        switch self {
        case .scale1x: return "@1x"
        case .scale2x: return "@2x"
        case .scale3x: return "@3x"
        case .other(let scale): return "@\(scale)"
        }
    }
}

// MARK: InformationPrintable
private protocol InformationPrintable {
    func printWithLabel(label: String)
}

private extension InformationPrintable where Self: protocol<RawRepresentable, IncorrectValueAssertion> {
    func printWithLabel(label: String) {
        var text = "    \(label): \(self) (\(self.rawValue))"
        if !self.assertIncorrectValue() {
            text += " INCORRECT!"
        }
        print(text)
    }
}

private extension InformationPrintable where Self: protocol<InformationNameStringConvertible, IncorrectValueAssertion> {
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
extension ScaleFactor: InformationPrintable { }

// MARK: - PrintInformationOperation
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
            return "\(idiom): \(images.joinWithSeparator(","))"
        }

        // Create output for every idiom.
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
        func printProperty(label: String, value: Any?) {
            if let value = value {
                print("    \(label): \(value)")
            } else {
                print("    \(label): \(value)")
            }
        }

        print("  \(namedImage.acImageName):")
        namedImage.imageType.printWithLabel("imageType")
        namedImage.idiom().printWithLabel("idiom")
        namedImage.subtype().printWithLabel("subtype")
        namedImage.acScale.printWithLabel("scale")
        namedImage.sizeClassHorizontal().printWithLabel("size vlass horizontal")
        namedImage.sizeClassVertical().printWithLabel("size vlass vertical")
        printProperty("opacity", value: namedImage.opacity)
        printProperty("size", value: namedImage.size)
        printProperty("blend mode", value: namedImage.blendMode)
        namedImage.resizingMode.printWithLabel("resizing mode")
        printProperty("is template", value: namedImage.isTemplate)
        printProperty("vector based", value: namedImage.isVectorBased)
        printProperty("hasSliceInformation", value: namedImage.hasSliceInformation)
        namedImage.templateRenderingMode.printWithLabel("template rendering mode")
        printProperty("edge insets", value: namedImage.edgeInsets)
        printProperty("alignment edge insets", value: namedImage.alignmentEdgeInsets)
        printProperty("exifOrientation", value: namedImage.exifOrientation)
        printProperty("rendition name", value: namedImage._rendition().name())
        printProperty("rendition data", value: namedImage._rendition().data())
        printProperty("rendition pdf", value: namedImage._rendition().pdfDocument())
        printProperty("rendition image", value: namedImage._rendition().unslicedImage())
        printProperty("rendition UTI type", value: namedImage._rendition().utiType())
        printProperty("rendition type", value: namedImage._rendition().type())
        printProperty("rendition subtype", value: namedImage._rendition().subtype())
    }
}
