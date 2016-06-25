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
    var assetsContainer = AssetsContainer()
    let printOperation = PrintInformationOperation(verbose: .VeryVeryVerbose)

    // MARK: Setup
    override func setUp() {
        super.setUp()
        assetsContainer = AssetsContainer()
    }

    // MARK: Test correctness
    func testIOSCorrectness() {
        printOperation.read(assetsContainer.iOS)
    }

    func testIPadCorrectness() {
        printOperation.read(assetsContainer.iPad)
    }

    func testIPhoneCorrectness() {
        printOperation.read(assetsContainer.iPhone)
    }

    func testMacCorrectness() {
        printOperation.read(assetsContainer.macOS)
    }

    func testTVCorrectness() {
        printOperation.read(assetsContainer.tvOS)
    }

    func testWatchCorrectness() {
        printOperation.read(assetsContainer.watchOS)
    }
}
