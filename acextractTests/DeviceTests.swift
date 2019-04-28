//
//  DeviceTests.swift
//  acextract
//
//  Created by Bartosz Janda on 18.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class DeviceTests: XCTestCase {
    // MARK: Assets count
    func testiOSAssetsCount() {
        let assets = assetsContainer.iOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 6)
        XCTAssertTrue(assets.contains("d_ipad"))
        XCTAssertTrue(assets.contains("d_iphone"))
        XCTAssertTrue(assets.contains("d_iphone4"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testiPadAssetsCount() {
        let assets = assetsContainer.iPad.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_ipad"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testiPhoneAssetsCount() {
        let assets = assetsContainer.iPhone.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 5)
        XCTAssertTrue(assets.contains("d_iphone"))
        XCTAssertTrue(assets.contains("d_iphone4"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testMacAssetsCount() {
        let assets = assetsContainer.macOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_mac"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testTVAssetsCount() {
        let assets = assetsContainer.tvOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 2)
        XCTAssertTrue(assets.contains("d_tv"))
        XCTAssertTrue(assets.contains("d_universal"))
    }

    func testWatchAssetsCount() {
        let assets = assetsContainer.watchOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 3)
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
    }

    // MARK: Device images
    func testiPad() {
        let imageSet = assetsContainer.iPad.imageSet(withName: "d_ipad")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPad)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_ipad~ipad.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPad)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_ipad@2x~ipad.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone() {
        let imageSet = assetsContainer.iPhone.imageSet(withName: "d_iphone")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPhone)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone~iphone.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPhone)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone@2x~iphone.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPhone)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@3x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone@3x~iphone.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone4() {
        let imageSet = assetsContainer.iPhone.imageSet(withName: "d_iphone4")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.subtype() == .normal }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPhone)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone4@2x~iphone.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.subtype() == .iPhone4Inch }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.iPhone)
            XCTAssertEqual(image.subtype(), CUISubtype.iPhone4Inch)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone4-568h@2x~iphone.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testMac() {
        let imageSet = assetsContainer.macOS.imageSet(withName: "d_mac")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.universal)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_mac.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.universal)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_mac@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testTv() {
        let imageSet = assetsContainer.tvOS.imageSet(withName: "d_tv")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 1)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.appleTV)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_tv~tv.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testUniversal() {
        let imageSet = assetsContainer.tvOS.imageSet(withName: "d_universal")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.universal)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.universal)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.universal)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@3x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testWatch() {
        let imageSet = assetsContainer.watchOS.imageSet(withName: "d_watch")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.subtype() == .normal }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.appleWatch)
            XCTAssertEqual(image.subtype(), CUISubtype.normal)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch@2x~watch.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.subtype() == .appleWatch38 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.appleWatch)
            XCTAssertEqual(image.subtype(), CUISubtype.appleWatch38)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch-38@2x~watch.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.subtype() == .appleWatch42 }).first {
            XCTAssertEqual(image.idiom(), CUIDeviceIdiom.appleWatch)
            XCTAssertEqual(image.subtype(), CUISubtype.appleWatch42)
            XCTAssertEqual(image.acScale.name, "@2x")
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch-42@2x~watch.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
