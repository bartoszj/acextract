//
//  AcextractTests.swift
//  AcextractTests
//
//  Created by Bartosz Janda on 12.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class FakeOperation: Operation {
    var executed = false

    func read(catalog: AssetsCatalog) throws {
        executed = true
    }
}

class AssetsCatalogTests: XCTestCase {

    // MARK: Tests
    /**
     Success
     */
    func testCreateAssetsCatalog01() {
        do {
            _ = try AssetsCatalog(path: Asset.assets.path)
        } catch {
            XCTFail("Cannot create AssetsCatalog object")
        }
    }

    /**
     File not found.
     */
    func testCreateAssetsCatalog02() {
        do {
            _ = try AssetsCatalog(path: "Fake path")
            XCTFail("AssetsCatalog should not be created")
        } catch AssetsCatalogError.FileDoesntExists {

        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }

    /**
     Incorrect file.
     */
    func testCreateAssetsCatalog03() {
        guard let path = Asset.bundle.pathForResource("data/fake_assets", ofType: nil) else {
            XCTFail("Cannot find fake asset")
            return
        }

        do {
            _ = try AssetsCatalog(path: path)
            XCTFail("AssetsCatalog should not be created")
        } catch AssetsCatalogError.CannotOpenAssetsCatalog {

        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }

    /**
     Test one operation.
     */
    func testOperation01() {
        do {
            let operation = FakeOperation()
            try assetsContainer.iOS.performOperation(operation)
            XCTAssertTrue(operation.executed)
        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }

    /**
     Test two operations.
     */
    func testOperation02() {
        do {
            let operation1 = FakeOperation()
            let operation2 = FakeOperation()
            try assetsContainer.iOS.performOperations([operation1, operation2])
            XCTAssertTrue(operation1.executed)
            XCTAssertTrue(operation2.executed)
        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }
}
