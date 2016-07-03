//
//  MemoryClassTests.swift
//  acextract
//
//  Created by Bartosz Janda on 03.07.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import XCTest

class MemoryClassTests: XCTestCase {
    // MARK: Memory class
    func testNone() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "m_no")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 3)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_no.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_no@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_no@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test1GB() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "m_1gb")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_1gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_1gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_1gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 1GB 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Memory1GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.acImageName, "m_1gb1gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 1GB 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Memory1GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.acImageName, "m_1gb1gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 1GB 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Memory1GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory1GB)
            XCTAssertEqual(image.acImageName, "m_1gb1gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test2GB() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "m_2gb")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_2gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_2gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_2gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 2GB 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Memory2GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.acImageName, "m_2gb2gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 2GB 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Memory2GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.acImageName, "m_2gb2gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 2GB 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Memory2GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory2GB)
            XCTAssertEqual(image.acImageName, "m_2gb2gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }

    func test4GB() {
        let imageSet = assetsContainer.iOS.imageSet(withName: "m_4gb")
        let images = imageSet.namedImages
        XCTAssertEqual(images.count, 6)

        // Default 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_4gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_4gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // Default 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Default }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Default)
            XCTAssertEqual(image.acImageName, "m_4gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 4GB 1x
        if let image = images.filter({ return $0.scale == 1.0 && $0.memoryClass() == .Memory4GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.acImageName, "m_4gb4gb.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 4GB 2x
        if let image = images.filter({ return $0.scale == 2.0 && $0.memoryClass() == .Memory4GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.acImageName, "m_4gb4gb@2x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }

        // 4GB 3x
        if let image = images.filter({ return $0.scale == 3.0 && $0.memoryClass() == .Memory4GB }).first {
            XCTAssertEqual(image.memoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.baseKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.renditionKey().themeMemoryClass(), CUIMemoryClass.Memory4GB)
            XCTAssertEqual(image.acImageName, "m_4gb4gb@3x.png")
            XCTAssertNotNil(image._rendition().unslicedImage())
        } else {
            XCTFail("Cannot find image")
        }
    }
}
