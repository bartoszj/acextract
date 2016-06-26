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
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Default)
            XCTAssertEqual(image.acImageName, "r_default.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Default)
            XCTAssertEqual(image.acImageName, "r_default@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Default)
            XCTAssertEqual(image.acImageName, "r_default@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testOriginal() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "r_original")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Original)
            XCTAssertEqual(image.acImageName, "r_original.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Original)
            XCTAssertEqual(image.acImageName, "r_original@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Original)
            XCTAssertEqual(image.acImageName, "r_original@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testTemplate() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "r_template")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Template)
            XCTAssertEqual(image.acImageName, "r_template.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Template)
            XCTAssertEqual(image.acImageName, "r_template@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.templateRenderingMode, CUIRenderMode.Template)
            XCTAssertEqual(image.acImageName, "r_template@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }
}
