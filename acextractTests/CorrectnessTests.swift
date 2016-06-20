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
    var iOS: AssetsCatalog!
    var iPad: AssetsCatalog!
    var iPhone: AssetsCatalog!
    var macOS: AssetsCatalog!
    var tvOS: AssetsCatalog!
    var watchOS: AssetsCatalog!
    let printOperation = PrintInformationOperation(verbose: .VeryVerbose)

    // Setup
    override func setUp() {
        super.setUp()

        do {
            iOS = try AssetsCatalog(path: Assets.iOS.path)
            iPad = try AssetsCatalog(path: Assets.iPad.path)
            iPhone = try AssetsCatalog(path: Assets.iPhone.path)
            macOS = try AssetsCatalog(path: Assets.macOS.path)
            tvOS = try AssetsCatalog(path: Assets.tvOS.path)
            watchOS = try AssetsCatalog(path: Assets.watchOS.path)
        } catch {
            XCTFail("Cannot create assets")
        }
    }

    // MARK: Test correctness
    func testIOSCorrectness() {
        printOperation.read(iOS)
    }

    func testIPadCorrectness() {
        printOperation.read(iPad)
    }

    func testIPhoneCorrectness() {
        printOperation.read(iPhone)
    }

    func testMacCorrectness() {
        printOperation.read(macOS)
    }

//    func testTVCorrectness() {
//        printOperation.read(tvOS)
//    }

    func testWatchCorrectness() {
        printOperation.read(watchOS)
    }
}
