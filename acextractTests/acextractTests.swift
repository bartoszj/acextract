//
//  acextractTests.swift
//  acextractTests
//
//  Created by Bartosz Janda on 12.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

enum Assets: String {
    case iOS = "data/assets_ios"
    case iPhone = "data/assets_iphone"
    case iPad = "data/assets_ipad"
    case macOS = "data/assets_mac"
    case tvOS = "data/assets_mtv"
    case watchOS = "data/assets_watch"

    var path: String {
        guard let bundle = NSBundle(identifier: "com.bjanda.acextractTests") else {
            XCTFail("Missing bundle")
            preconditionFailure()
        }

        guard let path = bundle.pathForResource(self.rawValue, ofType: "car") else {
            XCTFail("Missing car file")
            preconditionFailure()
        }

        return path
    }
}

class acextractTests: XCTestCase {

    // MARK: Setup
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testCreateAssetsCatalog_Success() {
        do {
            _ = try AssetsCatalog(filePath: Assets.iOS.path)
        } catch {
            XCTFail("Cannot create AssetsCatalog object")
        }
    }

    func testCreateAssetsCatalog_Failure() {
        do {
            _ = try AssetsCatalog(filePath: "Fake path")
            XCTFail("AssetsCatalog should not be created")
        } catch AssetsCatalogError.FileDoesntExists {

        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }
}
