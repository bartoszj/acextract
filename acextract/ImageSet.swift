//
//  ImageSet.swift
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

private let escapeSeq = "\u{1b}"

private struct ImageSetIdioms {
    // MARK: - Properties
    var universal1x = false
    var universal2x = false
    var universal3x = false
    var universalVector = false

    var iPhone1x = false
    var iPhone1x_4Inch = false
    var iPhone2x = false
    var iPhone2x_4Inch = false
    var iPhone3x = false
    var iPhone3x_4Inch = false
    var iPhoneVector = false
    var iPhoneVector_4Inch = false

    var iPad1x = false
    var iPad2x = false
    var iPad3x = false
    var iPadVector = false

    var AppleWatch = false
    var AppleWatch38 = false
    var AppleWatch42 = false

    // MARK: - Initialization
    init(namedImages: [CUINamedImage]) {
        for namedImage in namedImages {
            switch namedImage.ac_basicType {
            case .Universal1x:
                self.universal1x = true
            case .Universal2x:
                self.universal2x = true
            case .Universal3x:
                self.universal3x = true
            case .UniversalVector:
                self.universalVector = true

            case .iPhone1x:
                self.iPhone1x = true
            case .iPhone1x_4Inch:
                self.iPhone1x_4Inch = true
            case .iPhone2x:
                self.iPhone2x = true
            case .iPhone2x_4Inch:
                self.iPhone2x_4Inch = true
            case .iPhone3x:
                self.iPhone3x = true
            case .iPhone3x_4Inch:
                self.iPhone3x_4Inch = true
            case .iPhoneVector:
                self.iPhoneVector = true
            case .iPhoneVector_4Inch:
                self.iPhoneVector_4Inch = true

            case .iPad1x:
                self.iPad1x = true
            case .iPad2x:
                self.iPad2x = true
            case .iPad3x:
                self.iPad3x = true
            case .iPadVector:
                self.iPadVector = true

            case .AppleWatch:
                self.AppleWatch = true
            case .AppleWatch38:
                self.AppleWatch38 = true
            case .AppleWatch42:
                self.AppleWatch42 = true

            case .NotRecognized:
                break
            }
        }
    }

    // MARK: - Methods
    func shortDescription() -> String {
        // Universal.
        var devices = [String]()
        if universal1x || universal2x || universal3x || universalVector {
            var images = [String]()
            if universal1x {
                images.append("@1x")
            }
            if universal2x {
                images.append("@2x")
            }
            if universal3x {
                images.append("@3x")
            }
            if universalVector {
                images.append("vector")
            }
            devices.append("universal: " + images.joinWithSeparator(","))
        }

        // iPhone.
        if iPhone1x || iPhone1x_4Inch || iPhone2x || iPhone2x_4Inch || iPhone3x || iPhone3x_4Inch || iPhoneVector || iPhoneVector_4Inch {
            var images = [String]()
            if iPhone1x {
                images.append("@1x")
            }
            if iPhone1x_4Inch {
                images.append("-568@1x")
            }
            if iPhone2x {
                images.append("@2x")
            }
            if iPhone2x_4Inch {
                images.append("-568@2x")
            }
            if iPhone3x {
                images.append("@3x")
            }
            if iPhone3x_4Inch {
                images.append("-568h@3x")
            }
            if iPhoneVector {
                images.append("vector")
            }
            if iPhoneVector_4Inch {
                images.append("vector-568h")
            }
            devices.append("iPhone: " + images.joinWithSeparator(","))
        }

        // iPad
        if iPad1x || iPad2x || iPad3x || iPadVector {
            var images = [String]()
            if iPad1x {
                images.append("@1x")
            }
            if iPad2x {
                images.append("@2x")
            }
            if iPad3x {
                images.append("@3x")
            }
            if iPadVector {
                images.append("vector")
            }
            devices.append("iPad: " + images.joinWithSeparator(","))
        }

        // Apple Watch
        if AppleWatch || AppleWatch38 || AppleWatch42 {
            var images = [String]()
            if AppleWatch {
                images.append("-0")
            }
            if AppleWatch38 {
                images.append("-38")
            }
            if AppleWatch42 {
                images.append("-42")
            }
            devices.append("AppleWatch: " + images.joinWithSeparator(","))
        }

        return devices.joinWithSeparator("; ")
    }
}

class ImageSet {
    // MARK: - Properties
    let name: String
    let namedImages: [CUINamedImage]
    private lazy var imageIdioms: ImageSetIdioms = ImageSetIdioms(namedImages: self.namedImages)

    // MARK: - Initialization
    init(name: String, namedImages: [CUINamedImage]) {
        self.name = name
        self.namedImages = namedImages
    }

    // MARK: - Methods
    func verboseDescription(verbose: Int) -> String {
        switch verbose {
        case 0:
            return self.name
        case 1:
            return "\(escapeSeq)[1m\(self.name)\(escapeSeq)[0m: \(self.imageIdioms.shortDescription())"
        case 2:
            var desc = "\(escapeSeq)[1m\(self.name)\(escapeSeq)[0m:\n"
            for namedImage in self.namedImages {
                desc += "  \(namedImage.ac_imageName)\n"
            }
            return desc
        default:
            var desc = "\(escapeSeq)[1m\(self.name)\(escapeSeq)[0m:\n"
            for namedImage in self.namedImages {
                desc += "  \(namedImage.ac_imageName):\n"
                desc += "    imageType: \(namedImage.imageType)\n"
                desc += "    idiom: \(namedImage.idiom())\n"
                desc += "    subtype: \(namedImage.subtype())\n"
                desc += "    scale: \(namedImage.scale)\n"
                desc += "    size vlass horizontal: \(namedImage.sizeClassHorizontal())\n"
                desc += "    size vlass vertical: \(namedImage.sizeClassVertical())\n"
                desc += "    opacity: \(namedImage.opacity)\n"
                desc += "    size: \(namedImage.size)\n"
                desc += "    blend mode: \(namedImage.blendMode)\n"
                desc += "    resizing mode: \(namedImage.resizingMode)\n"
                desc += "    is template: \(namedImage.isTemplate)\n"
                desc += "    vector based: \(namedImage.isVectorBased)\n"
                desc += "    template rendering mode: \(namedImage.templateRenderingMode)\n"
                desc += "    edge insets: \(namedImage.edgeInsets)\n"
                desc += "    alignment edge insets: \(namedImage.alignmentEdgeInsets)\n"
                desc += "    alignment rect: \(namedImage.alignmentRect())\n"
                desc += "    exifOrientation: \(namedImage.exifOrientation)\n"
                desc += "    rendition name: \(namedImage._rendition().name())\n"
                desc += "    rendition data: \(namedImage._rendition().data())\n"
                desc += "    rendition pdf: \(namedImage._rendition().pdfDocument())\n"
                desc += "    rendition image: \(namedImage._rendition().unslicedImage())\n"
                desc += "    rendition UTI type: \(namedImage._rendition().utiType())\n"
                desc += "    rendition type: \(namedImage._rendition().type())\n"
                desc += "    rendition subtype: \(namedImage._rendition().subtype())\n"
            }
            return desc
        }
    }
}

extension ImageSet: CustomStringConvertible {
    var description: String {
        return self.verboseDescription(1)
    }
}

extension ImageSet: CustomDebugStringConvertible {
    var debugDescription: String {
        return self.description
    }
}