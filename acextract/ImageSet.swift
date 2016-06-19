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

//private struct ImageSetIdioms {
//    // MARK: Properties
//    var universal1x = false
//    var universal2x = false
//    var universal3x = false
//    var universalVector = false
//
//    var iPhone1x = false
//    var iPhone1x4Inch = false
//    var iPhone2x = false
//    var iPhone2x4Inch = false
//    var iPhone3x = false
//    var iPhone3x4Inch = false
//    var iPhoneVector = false
//    var iPhoneVector4Inch = false
//
//    var iPad1x = false
//    var iPad2x = false
//    var iPad3x = false
//    var iPadVector = false
//
//    var appleWatch = false
//    var appleWatch38 = false
//    var appleWatch42 = false
//
//    // MARK: Initialization
//    init(namedImages: [CUINamedImage]) {
//        for namedImage in namedImages {
//            switch namedImage.acBasicType {
//            case .Universal1x:
//                self.universal1x = true
//            case .Universal2x:
//                self.universal2x = true
//            case .Universal3x:
//                self.universal3x = true
//            case .UniversalVector:
//                self.universalVector = true
//
//            case .iPhone1x:
//                self.iPhone1x = true
//            case .iPhone1x_4Inch:
//                self.iPhone1x4Inch = true
//            case .iPhone2x:
//                self.iPhone2x = true
//            case .iPhone2x_4Inch:
//                self.iPhone2x4Inch = true
//            case .iPhone3x:
//                self.iPhone3x = true
//            case .iPhone3x_4Inch:
//                self.iPhone3x4Inch = true
//            case .iPhoneVector:
//                self.iPhoneVector = true
//            case .iPhoneVector_4Inch:
//                self.iPhoneVector4Inch = true
//
//            case .iPad1x:
//                self.iPad1x = true
//            case .iPad2x:
//                self.iPad2x = true
//            case .iPad3x:
//                self.iPad3x = true
//            case .iPadVector:
//                self.iPadVector = true
//
//            case .AppleWatch:
//                self.appleWatch = true
//            case .AppleWatch38:
//                self.appleWatch38 = true
//            case .AppleWatch42:
//                self.appleWatch42 = true
//
//            case .NotRecognized:
//                break
//            }
//        }
//    }
//
//    // MARK: Methods
//    func shortDescription() -> String {
//        // Universal.
//        var devices = [String]()
//        if universal1x || universal2x || universal3x || universalVector {
//            var images = [String]()
//            if universal1x {
//                images.append("@1x")
//            }
//            if universal2x {
//                images.append("@2x")
//            }
//            if universal3x {
//                images.append("@3x")
//            }
//            if universalVector {
//                images.append("vector")
//            }
//            devices.append("universal: " + images.joinWithSeparator(","))
//        }
//
//        // iPhone.
//        if iPhone1x || iPhone1x4Inch || iPhone2x || iPhone2x4Inch || iPhone3x || iPhone3x4Inch || iPhoneVector || iPhoneVector4Inch {
//            var images = [String]()
//            if iPhone1x {
//                images.append("@1x")
//            }
//            if iPhone1x4Inch {
//                images.append("-568@1x")
//            }
//            if iPhone2x {
//                images.append("@2x")
//            }
//            if iPhone2x4Inch {
//                images.append("-568@2x")
//            }
//            if iPhone3x {
//                images.append("@3x")
//            }
//            if iPhone3x4Inch {
//                images.append("-568h@3x")
//            }
//            if iPhoneVector {
//                images.append("vector")
//            }
//            if iPhoneVector4Inch {
//                images.append("vector-568h")
//            }
//            devices.append("iPhone: " + images.joinWithSeparator(","))
//        }
//
//        // iPad
//        if iPad1x || iPad2x || iPad3x || iPadVector {
//            var images = [String]()
//            if iPad1x {
//                images.append("@1x")
//            }
//            if iPad2x {
//                images.append("@2x")
//            }
//            if iPad3x {
//                images.append("@3x")
//            }
//            if iPadVector {
//                images.append("vector")
//            }
//            devices.append("iPad: " + images.joinWithSeparator(","))
//        }
//
//        // Apple Watch
//        if appleWatch || appleWatch38 || appleWatch42 {
//            var images = [String]()
//            if appleWatch {
//                images.append("-0")
//            }
//            if appleWatch38 {
//                images.append("-38")
//            }
//            if appleWatch42 {
//                images.append("-42")
//            }
//            devices.append("AppleWatch: " + images.joinWithSeparator(","))
//        }
//
//        return devices.joinWithSeparator("; ")
//    }
//}

struct ImageSet {
    // MARK: Properties
    let name: String
    let namedImages: [CUINamedImage]

    // MARK: Initialization
    init(name: String, namedImages: [CUINamedImage]) {
        self.name = name
        self.namedImages = namedImages
    }

    var shortDesription: String {
        return ""
    }
}

extension ImageSet: CustomStringConvertible {
    var description: String {
        return self.shortDesription
    }
}
