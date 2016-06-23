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
    func read(catalg: AssetsCatalog) throws -> Void
}

struct CompoundOperation: Operation {
    let operations: [Operation]

    func read(catalg: AssetsCatalog) throws {
        for operation in operations {
            try operation.read(catalg)
        }
    }
}

// MARK: - Helpers
let escapeSeq = "\u{1b}"
let boldSeq = "[1m"
let resetSeq = "[0m"
let redColorSeq = "[31m"

// MARK: - ExtractOperation
enum ExtractOperationError: ErrorType {
    case OutputPathIsNotDirectory
    case RenditionMissingData
    case CannotSaveImage
    case CannotCreatePDFDocument
}

struct ExtractOperation: Operation {

    // MARK: Properties
    let outputPath: String

    // MARK: Initialization
    init(path: String) {
        outputPath = (path as NSString).stringByExpandingTildeInPath
    }

    // MARK: Methods
    func read(catalg: AssetsCatalog) throws {
        // Create output folder if needed
        try checkAndCreateFolder()
        // For every image set and every named image.
        for imageSet in catalg.imageSets {
            for namedImage in imageSet.namedImages {
                // Save image to file.
                extractNamedImage(namedImage)
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
        if NSFileManager.defaultManager().fileExistsAtPath(outputPath, isDirectory: &isDirectory) && !isDirectory {
            throw ExtractOperationError.OutputPathIsNotDirectory
        } else {
            try NSFileManager.defaultManager().createDirectoryAtPath(outputPath, withIntermediateDirectories: true, attributes: nil)
        }
    }

    /**
     Extract image to file.

     - parameter namedImage: Named image to save.
     */
    private func extractNamedImage(namedImage: CUINamedImage) {
        let filePath = (outputPath as NSString).stringByAppendingPathComponent(namedImage.acImageName)
        print("Extracting: \(namedImage.acImageName)", terminator: "")
        do {
            try namedImage.acSaveAtPath(filePath)
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
            try self.acSavePDF(filePath)
        } else if self._rendition().unslicedImage() != nil {
            try self.acSaveImage(filePath)
        } else {
            throw ExtractOperationError.RenditionMissingData
        }
    }

    func acSaveImage(filePath: String) throws {
        let filePathURL = NSURL(fileURLWithPath: filePath)
        let cgImage = self._rendition().unslicedImage().takeUnretainedValue()
        guard let cgDestination = CGImageDestinationCreateWithURL(filePathURL, kUTTypePNG, 1, nil) else {
            throw ExtractOperationError.CannotSaveImage
        }

        CGImageDestinationAddImage(cgDestination, cgImage, nil)

        if !CGImageDestinationFinalize(cgDestination) {
            throw ExtractOperationError.CannotSaveImage
        }
    }

    func acSavePDF(filePath: String) throws {
        // Based on:
        // http://stackoverflow.com/questions/3780745/saving-a-pdf-document-to-disk-using-quartz

        let cgPDFDocument = self._rendition().pdfDocument().takeUnretainedValue()
        // Create the pdf context
        let cgPage = CGPDFDocumentGetPage(cgPDFDocument, 1)
        var cgPageRect = CGPDFPageGetBoxRect(cgPage, .MediaBox)
        let mutableData = NSMutableData()

        let cgDataConsumer = CGDataConsumerCreateWithCFData(mutableData)
        let cgPDFContext = CGPDFContextCreate(cgDataConsumer, &cgPageRect, nil)
        defer {
            CGPDFContextClose(cgPDFContext)
        }

        if CGPDFDocumentGetNumberOfPages(cgPDFDocument) > 0 {
            CGPDFContextBeginPage(cgPDFContext, nil)
            CGContextDrawPDFPage(cgPDFContext, cgPage)
            CGPDFContextEndPage(cgPDFContext)
        } else {
            throw ExtractOperationError.CannotCreatePDFDocument
        }

        if !mutableData.writeToFile(filePath, atomically: true) {
            throw ExtractOperationError.CannotCreatePDFDocument
        }
    }
}
