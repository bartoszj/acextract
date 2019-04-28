//
//  CorrectnessTests.swift
//  acextract
//
//  Created by Bartosz Janda on 19.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

// Check correctness by printing verbose information
class CorrectnessTests: XCTestCase {
    // MARK: Properties
    let printOperation = PrintInformationOperation(verbose: .veryVeryVerbose)

    // MARK: Test correctness
    func testIOSCorrectness() {
        printOperation.read(catalog: assetsContainer.iOS)
    }

    func testIPadCorrectness() {
        printOperation.read(catalog: assetsContainer.iPad)
    }

    func testIPhoneCorrectness() {
        printOperation.read(catalog: assetsContainer.iPhone)
    }

    func testMacCorrectness() {
        printOperation.read(catalog: assetsContainer.macOS)
    }

    func testTVCorrectness() {
        printOperation.read(catalog: assetsContainer.tvOS)
    }

    func testWatchCorrectness() {
        printOperation.read(catalog: assetsContainer.watchOS)
    }

    func testPrintInformationName() {
        PrintInformationOperation(verbose: .name).read(catalog: assetsContainer.iOS)
    }

    func testPrintInformationVerbose() {
        PrintInformationOperation(verbose: .verbose).read(catalog: assetsContainer.iOS)
    }

    func testPrintInformationVeryVerbose() {
        PrintInformationOperation(verbose: .veryVerbose).read(catalog: assetsContainer.iOS)
    }
}
