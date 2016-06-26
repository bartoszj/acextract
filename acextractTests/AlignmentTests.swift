//
//  AlignmentTests.swift
//  acextract
//
//  Created by Bartosz Janda on 26.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class AlignmentTests: XCTestCase {
    // Image Alignment
    func testNoAlignment() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "a_no")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets())
            XCTAssertEqual(image.acImageName, "a_no.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets())
            XCTAssertEqual(image.acImageName, "a_no@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets())
            XCTAssertEqual(image.acImageName, "a_no@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testAnyAlignment() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "a_any")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets(top: 5, left: 10, bottom: 15, right: 20))
            XCTAssertEqual(image.acImageName, "a_any.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets(top: 3, left: 6, bottom: 9, right: 12))
            XCTAssertEqual(image.acImageName, "a_any@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.alignmentEdgeInsets, NSEdgeInsets(top: 4, left: 8, bottom: 12, right: 16))
            XCTAssertEqual(image.acImageName, "a_any@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }
}
