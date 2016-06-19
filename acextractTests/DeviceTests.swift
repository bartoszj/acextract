//
//  DeviceTests.swift
//  acextract
//
//  Created by Bartosz Janda on 18.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class DeviceTests: XCTestCase {
    var iOS: AssetsCatalog!
    var iPad: AssetsCatalog!
    var iPhone: AssetsCatalog!
    var macOS: AssetsCatalog!
    var tvOS: AssetsCatalog!
    var watchOS: AssetsCatalog!

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

    // MARK: Assets count
    func testiOSAssetsCount() {
        let assets = iOS.imageSets.map { $0.name }.filter { name in
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
        let assets = iPad.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_ipad"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testiPhoneAssetsCount() {
        let assets = iPhone.imageSets.map { $0.name }.filter { name in
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
        let assets = macOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_mac"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testTVAssetsCount() {
        let assets = tvOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 2)
        XCTAssertTrue(assets.contains("d_tv"))
        XCTAssertTrue(assets.contains("d_universal"))
    }

    func testWatchAssetsCount() {
        let assets = watchOS.imageSets.map { $0.name }.filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 3)
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
    }

    // MARK: Device images
    func testiPad() {
        let imageSet = iPad.imageSet(withName: "d_ipad")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPad1x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_ipad~ipad.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPad2x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_ipad@2x~ipad.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone() {
        let imageSet = iPhone.imageSet(withName: "d_iphone")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPhone1x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPhone2x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPhone3x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone@3x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone4() {
        let imageSet = iPhone.imageSet(withName: "d_iphone4")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .Normal }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPhone2x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone4@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .IPhone4Inch }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.iPhone2x_4Inch)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_iphone4-568h@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testMac() {
        let imageSet = macOS.imageSet(withName: "d_mac")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_mac.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal2x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_mac@2x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testTv() {
        let imageSet = tvOS.imageSet(withName: "d_tv")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 1)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_tv.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testUniversal() {
        let imageSet = tvOS.imageSet(withName: "d_universal")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal2x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.Universal3x)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_universal@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testWatch() {
        let imageSet = watchOS.imageSet(withName: "d_watch")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .Normal }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.AppleWatch)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .AppleWatch38 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.AppleWatch38)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch-38@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .AppleWatch42 }).first {
            XCTAssertEqual(image.acBasicType, NamedImageBasicType.AppleWatch42)
            XCTAssertEqual(image.acIsPDF, false)
            XCTAssertEqual(image.acImageName, "d_watch-42@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }
    }
}
