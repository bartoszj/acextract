//
//  GraphicalClassTests.swift
//  acextract
//
//  Created by Bartosz Janda on 29.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class GraphicalClassTests: XCTestCase {
    // MARK: Graphical class
    func testNone() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_none")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_none.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_none@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_none@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test1v2() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_1v2")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_1v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_1v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_1v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_1v21v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_1v21v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_1v21v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test2v2() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_2v2")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_2v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_2v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_2v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 2v2 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_2v22v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 2v2 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_2v22v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 2v2 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_2v22v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test3v1() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_3v1")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_3v1.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_3v1@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_3v1@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_3v13v1.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_3v13v1@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_3v13v1@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testMix_01() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_mix")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 12)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_mix.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_mix@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Default }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Default)
            XCTAssertEqual(image.acImageName, "g_mix@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_mix1v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_mix1v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 1v2 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal1v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal1v2)
            XCTAssertEqual(image.acImageName, "g_mix1v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func testMix_02() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "g_mix")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 12)

        // Metal 2v2 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_mix2v2.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 2v2 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_mix2v2@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 2v2 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal2v2 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal2v2)
            XCTAssertEqual(image.acImageName, "g_mix2v2@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_mix3v1.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_mix3v1@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Metal 3v1 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.graphicsClass() == .Metal3v1 }).first {
            XCTAssertEqual(image.graphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.baseKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.renditionKey().themeGraphicsClass(), CUIGraphicalClass.Metal3v1)
            XCTAssertEqual(image.acImageName, "g_mix3v1@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
