//
//  CoreUI_Swift.swift
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

// MARK: - Protocols
protocol NameStringConvertible {
    var name: String { get }
}

protocol ValueCorrectness {
    var correct: Bool { get }
}

protocol IncorrectValueAssertion {
    func assertIncorrectValue() -> Bool
}

extension IncorrectValueAssertion where Self: RawRepresentable & ValueCorrectness {
    func assertIncorrectValue() -> Bool {
        let c = correct
        assert(c, "Incorrect value: \(self) - \(rawValue)")
        return c
    }
}

protocol AllValues {
    static var allValues: [Self] { get }
}

// MARK: - Custom types
enum ScaleFactor {
    case scale1x
    case scale2x
    case scale3x
}

extension ScaleFactor: ExpressibleByFloatLiteral {
    init(floatLiteral value: Double) {
        switch value {
        case 1.0: self = .scale1x
        case 2.0: self = .scale2x
        case 3.0: self = .scale3x
        default: fatalError()
        }
    }
}

extension ScaleFactor: NameStringConvertible {
    var name: String {
        switch self {
        case .scale1x: return ""
        case .scale2x: return "@2x"
        case .scale3x: return "@3x"
        }
    }
}

// MARK: - CoreUI Extensions
extension NSEdgeInsets: Equatable { }
public func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
    return lhs.top == rhs.top
    && lhs.left == rhs.left
    && lhs.bottom == rhs.bottom
    && lhs.right == rhs.right
}

// MARK: CUIDeviceIdiom
extension CUIDeviceIdiom: NameStringConvertible {
    var name: String {
        // Idiom.
        switch self {
        case .universal: return ""
        case .iPhone: return "~iphone"
        case .iPad: return "~ipad"
        case .appleTV: return "~tv"
        case .appleWatch: return "~watch"
        default: return ""
        }
    }
}

extension CUIDeviceIdiom: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .universal: return rawValue == CUIDeviceIdiom.universal.rawValue
        case .iPhone: return rawValue == CUIDeviceIdiom.iPhone.rawValue
        case .iPad: return rawValue == CUIDeviceIdiom.iPad.rawValue
        case .appleTV: return rawValue == CUIDeviceIdiom.appleTV.rawValue
        case .appleWatch: return rawValue == CUIDeviceIdiom.appleWatch.rawValue
        default: return true
        }
    }
}

extension CUIDeviceIdiom: AllValues {
    static var allValues: [CUIDeviceIdiom] {
        return [.universal, .iPhone, .iPad, .appleTV, .appleWatch]
    }
}

extension CUIDeviceIdiom: CustomStringConvertible {
    public var description: String {
        switch self {
        case .universal: return "universal"
        case .iPhone: return "iPhone"
        case .iPad: return "iPad"
        case .appleTV: return "AppleTV"
        case .appleWatch: return "AppleWatch"
        default: return ""
        }
    }
}

// MARK: CUISubtype
extension CUISubtype: NameStringConvertible {
    var name: String {
        switch self {
        case .normal: return ""
        case .iPhone4Inch: return "-568h"
        case .appleWatch38: return "-38"
        case .appleWatch42: return "-42"
        default: return ""
        }
    }
}

extension CUISubtype: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .normal: return rawValue == CUISubtype.normal.rawValue
            case .iPhone4Inch: return rawValue == CUISubtype.iPhone4Inch.rawValue
            case .appleWatch38: return rawValue == CUISubtype.appleWatch38.rawValue
            case .appleWatch42: return rawValue == CUISubtype.appleWatch42.rawValue
            default: return true
        }
    }
}

extension CUISubtype: CustomStringConvertible {
    public var description: String {
        switch self {
            case .normal:
                return "normal"
            case .appleWatch38:
                return "-38"
            case .appleWatch42:
                return "-42"
            case .iPhone4Inch:
                return "-568h"
            default: return ""
        }
    }
}

// MARK: CUIUserInterfaceSizeClass
extension CUIUserInterfaceSizeClass: NameStringConvertible {
    var name: String {
        switch self {
            case .any: return "*"
            case .compact: return "-"
            case .regular: return "+"
            default: return ""
        }
    }
}

extension CUIUserInterfaceSizeClass: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .any: return rawValue == CUIUserInterfaceSizeClass.any.rawValue
            case .compact: return rawValue == CUIUserInterfaceSizeClass.compact.rawValue
            case .regular: return rawValue == CUIUserInterfaceSizeClass.regular.rawValue
            default: return true
        }
    }
}

extension CUIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
            case .any: return "any"
            case .compact: return "compact"
            case .regular: return "regular"
            default: return ""
        }
    }
}

// MARK: CUIRenderMode
extension CUIRenderMode: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .original: return rawValue == CUIRenderMode.original.rawValue
            case .template: return rawValue == CUIRenderMode.template.rawValue
            case .default: return rawValue == CUIRenderMode.default.rawValue
            default: return true
        }
    }
}

extension CUIRenderMode: CustomStringConvertible {
    public var description: String {
        switch self {
            case .original: return "original"
            case .template: return "template"
            case .default: return "default"
            default: return ""
        }
    }
}

// MARK: CUIResizingMode
extension CUIResizingMode: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .tiles: return rawValue == CUIResizingMode.tiles.rawValue
            case .stretches: return rawValue == CUIResizingMode.stretches.rawValue
            default: return true
        }
    }
}

extension CUIResizingMode: CustomStringConvertible {
    public var description: String {
        switch self {
            case .tiles: return "tiles"
            case .stretches: return "stretches"
            default: return ""
        }
    }
}

// MARK: CUIImageType
extension CUIImageType: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .none: return rawValue == CUIImageType.none.rawValue
            case .horizontal: return rawValue == CUIImageType.horizontal.rawValue
            case .vertical: return rawValue == CUIImageType.vertical.rawValue
            case .horizontalAndVertical: return rawValue == CUIImageType.horizontalAndVertical.rawValue
            default: return true
        }
    }
}

extension CUIImageType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .none: return "none"
            case .horizontal: return "horizontal"
            case .vertical: return "vertical"
            case .horizontalAndVertical: return "horizontal & vertical"
            default: return ""
        }
    }
}

// MARK: CUIGraphicalClass
extension CUIGraphicalClass: NameStringConvertible {
    var name: String {
        switch self {
            case .default: return ""
            case .metal1v2: return "1v2"
            case .metal2v2: return "2v2"
            case .metal3v1: return "3v1"
            default: return ""
        }
    }
}

extension CUIGraphicalClass: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .default: return rawValue == CUIGraphicalClass.default.rawValue
            case .metal1v2: return rawValue == CUIGraphicalClass.metal1v2.rawValue
            case .metal2v2: return rawValue == CUIGraphicalClass.metal2v2.rawValue
            case .metal3v1: return rawValue == CUIGraphicalClass.metal3v1.rawValue
            default: return true
        }
    }
}

extension CUIGraphicalClass: CustomStringConvertible {
    public var description: String {
        switch self {
            case .default: return "default"
            case .metal1v2: return "Metal 1v2"
            case .metal2v2: return "Metal 2v2"
            case .metal3v1: return "Metal 3v1"
            default: return ""
        }
    }
}

// MARK: CUIMemoryClass
extension CUIMemoryClass: NameStringConvertible {
    var name: String {
        switch self {
            case .default: return ""
            case .memory1GB: return "1gb"
            case .memory2GB: return "2gb"
            case .memory4GB: return "4gb"
            default: return ""
        }
    }
}

extension CUIMemoryClass: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
            case .default: return rawValue == CUIMemoryClass.default.rawValue
            case .memory1GB: return rawValue == CUIMemoryClass.memory1GB.rawValue
            case .memory2GB: return rawValue == CUIMemoryClass.memory2GB.rawValue
            case .memory4GB: return rawValue == CUIMemoryClass.memory4GB.rawValue
            default: return true
        }
    }
}

extension CUIMemoryClass: CustomStringConvertible {
    public var description: String {
        switch self {
            case .default: return "default"
            case .memory1GB: return "1GB"
            case .memory2GB: return "2GB"
            case .memory4GB: return "4GB"
            default: return ""
        }
    }
}

//MARK: CUINamedImage
extension CUINamedImage {
    var acScale: ScaleFactor {
        return ScaleFactor(floatLiteral: scale)
    }

    var acSizeClassString: String {
    switch (self.sizeClassHorizontal(), self.sizeClassVertical()) {
        case (.any, .any): return ""
        case let (horizontal, vertical): return "\(horizontal.name)\(vertical.name)"
        }
    }

    var acIsPDF: Bool {
        if self.isVectorBased && self.size == CGSize.zero {
            return true
        }
        return false
    }
    
    fileprivate var acFileExtension: String {
        if acIsPDF {
            return "pdf"
        }
        return "png"
    }


    var acImageName: String {
        // image size
        let width = self.size.width
        let height = self.size.height
        let size = width>0 ? "\(Int(width))x\(Int(height))" : ""

        // Graphical class
        let graphics = self.graphicsClass().name

        // Memory class
        let memory = self.memoryClass().name

        // Size class suffix
        let sizeClassSuffix = acSizeClassString

        // Subtype (4 inch)
        let subtype = self.subtype().name

        // Scale
        let scale = self.scale>1 ? "@\(Int(self.scale))x" : ""

        // Idiom
        let idiom = self.idiom().name

        // File extension
        let fileExtension = acFileExtension

        //  AppIcon76x76@2x~ipad.png
        return "\(self.name)\(size)\(graphics)\(memory)\(sizeClassSuffix)\(subtype)\(scale)\(idiom).\(fileExtension)"
    }
}

