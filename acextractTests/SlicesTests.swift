//
//  SlicesTests.swift
//  acextract
//
//  Created by Bartosz Janda on 27.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class SlicesTests: XCTestCase {

    // MARK: No slicing.
    func testNoSlicing() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "s_none")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertFalse(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.none)
            XCTAssertEqual(image._rendition().type(), CUIImageType.none)
            XCTAssertEqual(image.acImageName, "s_none.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertFalse(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.none)
            XCTAssertEqual(image._rendition().type(), CUIImageType.none)
            XCTAssertEqual(image.acImageName, "s_none@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertFalse(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.none)
            XCTAssertEqual(image._rendition().type(), CUIImageType.none)
            XCTAssertEqual(image.acImageName, "s_none@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testVertical() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "s_vertical")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.tiles)
            XCTAssertEqual(image.imageType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
            XCTAssertEqual(image.acImageName, "s_vertical.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
            XCTAssertEqual(image.acImageName, "s_vertical@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.tiles)
            XCTAssertEqual(image.imageType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 29, left: 0, bottom: 29, right: 0))
            XCTAssertEqual(image.acImageName, "s_vertical@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testHorizontal() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "s_horizontal")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.tiles)
            XCTAssertEqual(image.imageType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            XCTAssertEqual(image.acImageName, "s_horizontal.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 0, left: 20, bottom: 0, right: 19))
            XCTAssertEqual(image.acImageName, "s_horizontal@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 0, left: 29, bottom: 0, right: 29))
            XCTAssertEqual(image.acImageName, "s_horizontal@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testHorizontal_and_vertical() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "s_horizontal_vertical")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.stretches)
            XCTAssertEqual(image.imageType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 10, left: 11, bottom: 12, right: 13))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.tiles)
            XCTAssertEqual(image.imageType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 20, left: 20, bottom: 20, right: 19))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.tiles)
            XCTAssertEqual(image.imageType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.horizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 30, left: 30, bottom: 30, right: 29))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
