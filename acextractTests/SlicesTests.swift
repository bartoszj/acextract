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
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.None)
            XCTAssertEqual(image._rendition().type(), CUIImageType.None)
            XCTAssertEqual(image.acImageName, "s_none.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertFalse(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.None)
            XCTAssertEqual(image._rendition().type(), CUIImageType.None)
            XCTAssertEqual(image.acImageName, "s_none@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertFalse(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.None)
            XCTAssertEqual(image._rendition().type(), CUIImageType.None)
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
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Tiles)
            XCTAssertEqual(image.imageType, CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
            XCTAssertEqual(image.acImageName, "s_vertical.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 20, left: 0, bottom: 20, right: 0))
            XCTAssertEqual(image.acImageName, "s_vertical@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Tiles)
            XCTAssertEqual(image.imageType, CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Vertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Vertical)
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
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Tiles)
            XCTAssertEqual(image.imageType, CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            XCTAssertEqual(image.acImageName, "s_horizontal.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 0, left: 20, bottom: 0, right: 19))
            XCTAssertEqual(image.acImageName, "s_horizontal@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().type(), CUIImageType.Horizontal)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.Horizontal)
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
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Stretches)
            XCTAssertEqual(image.imageType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 10, left: 11, bottom: 12, right: 13))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Tiles)
            XCTAssertEqual(image.imageType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 20, left: 20, bottom: 20, right: 19))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.hasSliceInformation)
            XCTAssertEqual(image.resizingMode, CUIResizingMode.Tiles)
            XCTAssertEqual(image.imageType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().type(), CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.renditionType, CUIImageType.HorizontalAndVertical)
            XCTAssertEqual(image._rendition().sliceInformation()?.edgeInsets, NSEdgeInsets(top: 30, left: 30, bottom: 30, right: 29))
            XCTAssertEqual(image.acImageName, "s_horizontal_vertical@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
