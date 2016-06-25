//
//  AcextractTests.swift
//  AcextractTests
//
//  Created by Bartosz Janda on 12.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class AcextractTests: XCTestCase {

    // MARK: Tests
    func testCreateAssetsCatalog_Success() {
        do {
            _ = try AssetsCatalog(path: Asset.iOS.path)
        } catch {
            XCTFail("Cannot create AssetsCatalog object")
        }
    }

    func testCreateAssetsCatalog_Failure() {
        do {
            _ = try AssetsCatalog(path: "Fake path")
            XCTFail("AssetsCatalog should not be created")
        } catch AssetsCatalogError.FileDoesntExists {

        } catch {
            XCTFail("Unknown exception \(error)")
        }
    }
}
