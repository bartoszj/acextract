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

// MARK: - Protocols
protocol Operation {
    func read(catalog: AssetsCatalog) throws
}

struct CompoundOperation: Operation {
    let operations: [Operation]

    func read(catalog: AssetsCatalog) throws {
        for operation in operations {
            try operation.read(catalog: catalog)
        }
    }
}

// MARK: - Helpers
let escapeSeq = "\u{1b}"
let boldSeq = "[1m"
let resetSeq = "[0m"
let redColorSeq = "[31m"

// MARK: - ExtractOperation
enum ExtractOperationError: Error {
    case outputPathIsNotDirectory
    case renditionMissingData
    case cannotSaveImage
    case cannotCreatePDFDocument
}

struct ExtractOperation: Operation {

    // MARK: Properties
    let outputPath: String

    // MARK: Initialization
    init(path: String) {
        outputPath = (path as NSString).expandingTildeInPath
    }

    // MARK: Methods
    func read(catalog: AssetsCatalog) throws {
        // Create output folder if needed
        try checkAndCreateFolder()
        // For every image set and every named image.
        for imageSet in catalog.imageSets {
            for namedImage in imageSet.namedImages {
                // Save image to file.
                extractNamedImage(namedImage: namedImage)
            }
        }
    }

    // MARK: Private methods
    /**
     Checks if output folder exists nad create it if needed.

     - throws: Throws if output path is pointing to file, or it si not possible to create folder.
     */
    private func checkAndCreateFolder() throws {
        // Check if directory exists at given path and it is directory.
        var isDirectory: ObjCBool = false
        if FileManager.default.fileExists(atPath: outputPath, isDirectory: &isDirectory) && !(isDirectory.boolValue) {
            throw ExtractOperationError.outputPathIsNotDirectory
        } else {
            try FileManager.default.createDirectory(atPath: outputPath, withIntermediateDirectories: true, attributes: nil)
        }
    }

    /**
     Extract image to file.

     - parameter namedImage: Named image to save.
     */
    private func extractNamedImage(namedImage: CUINamedImage) {
        let filePath = (outputPath as NSString).appendingPathComponent(namedImage.acImageName)
        print("Extracting: \(namedImage.acImageName)", terminator: "")
        do {
            try namedImage.acSaveAtPath(filePath: filePath)
            print(" \(escapeSeq+boldSeq)OK\(escapeSeq+resetSeq)")
        } catch {
            print(" \(escapeSeq+boldSeq)\(escapeSeq+redColorSeq)FAILED\(escapeSeq+resetSeq) \(error)")
        }
    }
}

private extension CUINamedImage {
    /**
     Extract given image as PNG or PDF file.

     - parameter filePath: Path where file should be saved.

     - throws: Thorws if there is no image data.
     */
    func acSaveAtPath(filePath: String) throws {
        if self._rendition().pdfDocument() != nil {
            try self.acSavePDF(filePath: filePath)
        } else if self._rendition().unslicedImage() != nil {
            try self.acSaveImage(filePath: filePath)
        } else {
            throw ExtractOperationError.renditionMissingData
        }
    }

    func acSaveImage(filePath: String) throws {
        let filePathURL = NSURL(fileURLWithPath: filePath)
        
        try FileManager.default.createDirectory(at: filePathURL.deletingLastPathComponent! as URL, withIntermediateDirectories: true, attributes: nil)
        
        guard let cgImage = self._rendition().unslicedImage()?.takeUnretainedValue() else {
            throw ExtractOperationError.cannotSaveImage
        }
        guard let cgDestination = CGImageDestinationCreateWithURL(filePathURL, kUTTypePNG, 1, nil) else {
            throw ExtractOperationError.cannotSaveImage
        }

        CGImageDestinationAddImage(cgDestination, cgImage, nil)

        if !CGImageDestinationFinalize(cgDestination) {
            throw ExtractOperationError.cannotSaveImage
        }
    }

    func acSavePDF(filePath: String) throws {
        // Based on:
        // http://stackoverflow.com/questions/3780745/saving-a-pdf-document-to-disk-using-quartz

        guard let cgPDFDocument = self._rendition().pdfDocument()?.takeUnretainedValue() else {
            throw ExtractOperationError.cannotCreatePDFDocument
        }
        // Create the pdf context
        let cgPage = CGPDFDocument.page(cgPDFDocument) as! CGPDFPage // swiftlint:disable:this force_cast
        var cgPageRect = cgPage.getBoxRect(.mediaBox)
        let mutableData = NSMutableData()

        let cgDataConsumer = CGDataConsumer(data: mutableData)
        let cgPDFContext = CGContext(consumer: cgDataConsumer!, mediaBox: &cgPageRect, nil)
        defer {
            cgPDFContext!.closePDF()
        }

        if cgPDFDocument.numberOfPages > 0 {
            cgPDFContext!.beginPDFPage(nil)
            cgPDFContext!.drawPDFPage(cgPage)
            cgPDFContext!.endPDFPage()
        } else {
            throw ExtractOperationError.cannotCreatePDFDocument
        }

        if !mutableData.write(toFile: filePath, atomically: true) {
            throw ExtractOperationError.cannotCreatePDFDocument
        }
    }
}
