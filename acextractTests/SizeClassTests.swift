//
//  SizeClassTests.swift
//  acextract
//
//  Created by Bartosz Janda on 26.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class SizeClassTests: XCTestCase {
    // MARK: Size classes
    func testAnyCompact() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "sc_w_a&c")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Any 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.sizeClassHorizontal() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.sizeClassHorizontal() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.sizeClassHorizontal() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c@3x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Compact 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.sizeClassHorizontal() == .Compact }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "-")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c-*.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Compact 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.sizeClassHorizontal() == .Compact }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "-")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c-*@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Compact 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.sizeClassHorizontal() == .Compact }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "-")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_w_a&c-*@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testAnyRegular() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "sc_h_a&r")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Any 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.sizeClassVertical() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_h_a&r.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.sizeClassVertical() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_h_a&r@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.sizeClassVertical() == .Any }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_h_a&r@3x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.sizeClassVertical() == .Regular }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "+")
            XCTAssertEqual(image.acImageName, "sc_h_a&r*+.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.sizeClassVertical() == .Regular }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "+")
            XCTAssertEqual(image.acImageName, "sc_h_a&r*+@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.sizeClassVertical() == .Regular }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "+")
            XCTAssertEqual(image.acImageName, "sc_h_a&r*+@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testAnyRegularCompact_01() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "sc_wh_a&r&c")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 12)

        // Any Any 1x
        let aaImages = images.filter({ $0.sizeClassHorizontal() == .Any && $0.sizeClassVertical() == .Any })
        if let image = aaImages.filter({ $0.scale == 1.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any Any 2x
        if let image = aaImages.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any Any 3x
        if let image = aaImages.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c@3x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any Compact 1x
        let acImages = images.filter({ $0.sizeClassHorizontal() == .Any && $0.sizeClassVertical() == .Compact })
        if let image = acImages.filter({ $0.scale == 1.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c*-.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any Compact 2x
        if let image = acImages.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c*-@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Any Compact 3x
        if let image = acImages.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "*")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c*-@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testAnyRegularCompact_02() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "sc_wh_a&r&c")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 12)

        // Regular Any 1x
        let raImages = images.filter({ $0.sizeClassHorizontal() == .Regular && $0.sizeClassVertical() == .Any })
        if let image = raImages.filter({ $0.scale == 1.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+*.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular Any 2x
        if let image = raImages.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+*@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular Any 3x
        if let image = raImages.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Any)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "*")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+*@3x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular Compact 1x
        let rcImages = images.filter({ $0.sizeClassHorizontal() == .Regular && $0.sizeClassVertical() == .Compact })
        if let image = rcImages.filter({ $0.scale == 1.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+-.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular Compact 2x
        if let image = rcImages.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+-@2x.png")
        } else {
            XCTFail("Cannot find image")
        }

        // Regular Compact 3x
        if let image = rcImages.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.sizeClassHorizontal(), CUIUserInterfaceSizeClass.Regular)
            XCTAssertEqual(image.sizeClassVertical(), CUIUserInterfaceSizeClass.Compact)
            XCTAssertEqual(image.sizeClassHorizontal().name, "+")
            XCTAssertEqual(image.sizeClassVertical().name, "-")
            XCTAssertEqual(image.acImageName, "sc_wh_a&r&c+-@3x.png")
        } else {
            XCTFail("Cannot find image")
        }
    }
}
