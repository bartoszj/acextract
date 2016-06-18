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
        let assets = iOS.allImageNames().filter { name in
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
        let assets = iPad.allImageNames().filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_ipad"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testiPhoneAssetsCount() {
        let assets = iPhone.allImageNames().filter { name in
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
        let assets = macOS.allImageNames().filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 4)
        XCTAssertTrue(assets.contains("d_mac"))
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac"))
    }

    func testTVAssetsCount() {
        let assets = tvOS.allImageNames().filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 2)
        XCTAssertTrue(assets.contains("d_tv"))
        XCTAssertTrue(assets.contains("d_universal"))
    }

    func testWatchAssetsCount() {
        let assets = watchOS.allImageNames().filter { name in
            return name.hasPrefix("d_")
        }
        XCTAssertEqual(assets.count, 3)
        XCTAssertTrue(assets.contains("d_universal"))
        XCTAssertTrue(assets.contains("d_watch"))
        XCTAssertTrue(assets.contains("d_iphone_ipad_mac_watch"))
    }

    // MARK: Device images
    func testiPad() {
        let images = iPad.imagesWithName("d_ipad")
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPad1x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_ipad~ipad.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPad2x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_ipad@2x~ipad.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone() {
        let images = iPhone.imagesWithName("d_iphone")
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPhone1x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_iphone~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPhone2x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_iphone@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPhone3x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_iphone@3x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testiPhone4() {
        let images = iPhone.imagesWithName("d_iphone4")
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .Normal }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPhone2x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_iphone4@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .IPhone4Inch }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.iPhone2x_4Inch)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_iphone4-568h@2x~iphone.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testMac() {
        let images = macOS.imagesWithName("d_mac")
        XCTAssertEqual(images.count, 2)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_mac.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal2x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_mac@2x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testTv() {
        let images = tvOS.imagesWithName("d_tv")
        XCTAssertEqual(images.count, 1)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_tv.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testUniversal() {
        let images = tvOS.imagesWithName("d_universal")
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal1x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_universal.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal2x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_universal@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.Universal3x)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_universal@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testWatch() {
        let images = watchOS.imagesWithName("d_watch")
        XCTAssertEqual(images.count, 3)
        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .Normal }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.AppleWatch)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_watch@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .AppleWatch38 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.AppleWatch38)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_watch-38@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }

        if let image = images.filter({ return $0.scale == 2.0 && $0.subtype() == .AppleWatch42 }).first {
            XCTAssertEqual(image.ac_basicType, NamedImageBasicType.AppleWatch42)
            XCTAssertEqual(image.ac_isPDF, false)
            XCTAssertEqual(image.ac_imageName, "d_watch-42@2x~watch.png")
        } else {
            XCTFail("Cannot find image")
        }
    }
}
