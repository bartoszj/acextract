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

extension IncorrectValueAssertion where Self: protocol<RawRepresentable, ValueCorrectness> {
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
enum CoreUIError: ErrorType {
    case RenditionMissingData
    case RenditionMissingImage
    case RenditionMissingPDF
    case CannotCreatePDFDocument
    case CannotSaveImage
}

enum ScaleFactor {
    case scale1x
    case scale2x
    case scale3x
    case other(Double)
}

extension ScaleFactor: FloatLiteralConvertible {
    init(floatLiteral value: Double) {
        switch value {
        case 1.0: self = .scale1x
        case 2.0: self = .scale2x
        case 3.0: self = .scale3x
        default: self = .other(value)
        }
    }
}

extension ScaleFactor: NameStringConvertible {
    var name: String {
        switch self {
        case .scale1x: return ""
        case .scale2x: return "@2x"
        case .scale3x: return "@3x"
        case .other: return "other(\(self))"
        }
    }
}

extension ScaleFactor: ValueCorrectness {
    var correct: Bool {
        if case .other(_) = self {
            return false
        }
        return true
    }
}

extension ScaleFactor: IncorrectValueAssertion {
    func assertIncorrectValue() -> Bool {
        let c = correct
        assert(c, "Incorrect value: \(self)")
        return c
    }
}

// MARK: - CoreUI Extensions
// MARK: CUIImageInsets
extension CUIImageInsets: CustomStringConvertible {
    public var description: String {
        return "(\(top),\(left),\(bottom),\(right))"
    }
}

// MARK: CUIDeviceIdiom
extension CUIDeviceIdiom: NameStringConvertible {
    var name: String {
        // Idiom.
        switch self {
        case .Universal: return ""
        case .IPhone: return "~iphone"
        case .IPad: return "~ipad"
        case .AppleTV: return "~tv"
        case .AppleWatch: return "~watch"
        }
    }
}

extension CUIDeviceIdiom: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .Universal: return rawValue == Universal.rawValue
        case .IPhone: return rawValue == IPhone.rawValue
        case .IPad: return rawValue == IPad.rawValue
        case .AppleTV: return rawValue == AppleTV.rawValue
        case .AppleWatch: return rawValue == AppleWatch.rawValue
        }
    }
}

extension CUIDeviceIdiom: AllValues {
    static var allValues: [CUIDeviceIdiom] {
        return [.Universal, .IPhone, .IPad, .AppleTV, .AppleWatch]
    }
}

extension CUIDeviceIdiom: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Universal: return "universal"
        case .IPhone: return "iPhone"
        case .IPad: return "iPad"
        case .AppleTV: return "AppleTV"
        case .AppleWatch: return "AppleWatch"
        }
    }
}

// MARK: CUISubtype
extension CUISubtype: NameStringConvertible {
    var name: String {
        switch self {
        case .Normal: return ""
        case .IPhone4Inch: return "-568h"
        case .AppleWatch38: return "-38"
        case .AppleWatch42: return "-42"
        }
    }
}

extension CUISubtype: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .Normal: return rawValue == Normal.rawValue
        case .IPhone4Inch: return rawValue == IPhone4Inch.rawValue
        case .AppleWatch38: return rawValue == AppleWatch38.rawValue
        case .AppleWatch42: return rawValue == AppleWatch42.rawValue
        }
    }
}

extension CUISubtype: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Normal: return "normal"
        case .IPhone4Inch: return "-568h"
        case .AppleWatch38: return "-38"
        case .AppleWatch42: return "-42"
        }
    }
}

// MARK: CUIUserInterfaceSizeClass
extension CUIUserInterfaceSizeClass: NameStringConvertible {
    var name: String {
        switch self {
        case .Any: return "*"
        case .Compact: return "-"
        case .Regular: return "+"
        }
    }
}

extension CUIUserInterfaceSizeClass: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .Any: return rawValue == Any.rawValue
        case .Compact: return rawValue == Compact.rawValue
        case .Regular: return rawValue == Regular.rawValue
        }
    }
}

extension CUIUserInterfaceSizeClass: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Any: return "any"
        case .Compact: return "compact"
        case .Regular: return "regular"
        }
    }
}

// MARK: CUIRenderMode
extension CUIRenderMode: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .Original: return rawValue == Original.rawValue
        case .Template: return rawValue == Template.rawValue
        case .Default: return rawValue == Default.rawValue
        }
    }
}

extension CUIRenderMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Original: return "original"
        case .Template: return "template"
        case .Default: return "default"
        }
    }
}

// MARK: CUIResizingMode
extension CUIResizingMode: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .Tiles: return rawValue == Tiles.rawValue
        case .Stretches: return rawValue == Stretches.rawValue
        }
    }
}

extension CUIResizingMode: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Tiles: return "tiles"
        case .Stretches: return "stretches"
        }
    }
}

// MARK: CUIImageType
extension CUIImageType: ValueCorrectness, IncorrectValueAssertion {
    var correct: Bool {
        switch self {
        case .None: return rawValue == None.rawValue
        case .Horizontal: return rawValue == Horizontal.rawValue
        case .Vertical: return rawValue == Vertical.rawValue
        case .HorizontalAndVertical: return rawValue == HorizontalAndVertical.rawValue
        }
    }
}

extension CUIImageType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .None: return "none"
        case .Horizontal: return "horizontal"
        case .Vertical: return "vertical"
        case .HorizontalAndVertical: return "horizontal & vertical"
        }
    }
}

// MARK: CUINamedImage
extension CUINamedImage {
    var acScale: ScaleFactor {
        return ScaleFactor(floatLiteral: scale)
    }

    var acSizeClassString: String {
        switch (self.sizeClassHorizontal(), self.sizeClassVertical()) {
        case (.Any, .Any): return ""
        case let (horizontal, vertical): return "\(horizontal.name)\(vertical.name)"
        }
    }

    private var acFileExtension: String {
        if acIsPDF {
            return "pdf"
        }
        return "png"
    }

    var acIsPDF: Bool {
        if self.isVectorBased && self.size == CGSize.zero {
            return true
        }
        return false
    }

    var acImageName: String {
        // Size class suffix
        let sizeClassSuffix = acSizeClassString

        // Scale
        let scale = self.acScale.name

        // File extension
        let fileExtension = acFileExtension

        // Subtype (4 inch)
        let subtype = self.subtype().name

        // Idiom
        let idiom = self.idiom().name

        return "\(self.name)\(sizeClassSuffix)\(subtype)\(scale)\(idiom).\(fileExtension)"
    }

    private func acSaveAtPath(filePath: String) throws {
        if self._rendition().pdfDocument() != nil {
            try self.acSavePDFToDirectory(filePath)
        } else if self._rendition().unslicedImage() != nil {
            try self.acSaveImageToDirectory(filePath)
        } else {
            throw CoreUIError.RenditionMissingData
        }
    }

    private func acSaveImageToDirectory(filePath: String) throws {
        let filePathURL = NSURL(fileURLWithPath: filePath)
        let cgImage = self._rendition().unslicedImage().takeUnretainedValue()
        guard let cgDestination = CGImageDestinationCreateWithURL(filePathURL, kUTTypePNG, 1, nil) else {
            throw CoreUIError.CannotSaveImage
        }

        CGImageDestinationAddImage(cgDestination, cgImage, nil)

        if !CGImageDestinationFinalize(cgDestination) {
            throw CoreUIError.CannotSaveImage
        }
    }

    private func acSavePDFToDirectory(filePath: String) throws {
        // Based on:
        // http://stackoverflow.com/questions/3780745/saving-a-pdf-document-to-disk-using-quartz

        let cgPDFDocument = self._rendition().pdfDocument().takeUnretainedValue()
        // Create the pdf context
        let cgPage = CGPDFDocumentGetPage(cgPDFDocument, 1)
        var cgPageRect = CGPDFPageGetBoxRect(cgPage, .MediaBox)
        let mutableData = NSMutableData()

        let cgDataConsumer = CGDataConsumerCreateWithCFData(mutableData)
        let cgPDFContext = CGPDFContextCreate(cgDataConsumer, &cgPageRect, nil)

        if CGPDFDocumentGetNumberOfPages(cgPDFDocument) > 0 {
            CGPDFContextBeginPage(cgPDFContext, nil)
            CGContextDrawPDFPage(cgPDFContext, cgPage)
            CGPDFContextEndPage(cgPDFContext)
        } else {
            throw CoreUIError.CannotCreatePDFDocument
        }

        CGPDFContextClose(cgPDFContext)

        let success = mutableData.writeToFile(filePath, atomically: true)
        if !success {
            throw CoreUIError.CannotCreatePDFDocument
        }
    }
}
