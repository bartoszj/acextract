//
//  TemplateRenderingTests.swift
//  acextract
//
//  Created by Bartosz Janda on 26.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class TemplateRenderingTests: XCTestCase {
    // MARK: Template rendering
    func testDefault() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "r_default")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.default)
            XCTAssertEqual(image.acImageName, "r_default.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.default)
            XCTAssertEqual(image.acImageName, "r_default@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.default)
            XCTAssertEqual(image.acImageName, "r_default@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testOriginal() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "r_original")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.original)
            XCTAssertEqual(image.acImageName, "r_original.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.original)
            XCTAssertEqual(image.acImageName, "r_original@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertFalse(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.original)
            XCTAssertEqual(image.acImageName, "r_original@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testTemplate() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "r_template")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertTrue(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.template)
            XCTAssertEqual(image.acImageName, "r_template.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertTrue(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.template)
            XCTAssertEqual(image.acImageName, "r_template@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertTrue(image.isTemplate)
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.template)
            XCTAssertEqual(image.acImageName, "r_template@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
