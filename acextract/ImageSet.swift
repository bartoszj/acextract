//
//  ImageSet.swift
//  acextract
//
//  Created by Bartosz Janda on 15.12.2014.
//  Copyright (c) 2014 Bartosz Janda. All rights reserved.
//

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
            devices.append("universal: " + ",".join(images))
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
            devices.append("iPhone: " + ",".join(images))
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
            devices.append("iPad: " + ",".join(images))
        }
        
        return "; ".join(devices)
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
            return "\(escapeSeq)[1m\(self.name)\(escapeSeq)[0m: " + self.imageIdioms.shortDescription()
        case 2:
            var desc = "\(escapeSeq)[1m\(self.name)\(escapeSeq)[0m:\n"
            for namedImage in self.namedImages {
                desc += "  \(namedImage.ac_imageName):\n"
            }
            return desc
        default:
            return ""
        }
    }
}

extension ImageSet: Printable {
    var description: String {
        return self.verboseDescription(1)
    }
}

extension ImageSet: DebugPrintable {
    var debugDescription: String {
        return self.description
    }
}