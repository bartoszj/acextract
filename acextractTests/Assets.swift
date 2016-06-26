//
//  Assets.swift
//  acextract
//
//  Created by Bartosz Janda on 25.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import Foundation

let testBundleIdentifer = "com.bjanda.acextractTests"
let testBundle = NSBundle(identifier: testBundleIdentifer)

enum Asset: String {
    case iOS = "data/assets_ios"
    case iPhone = "data/assets_iphone"
    case iPad = "data/assets_ipad"
    case macOS = "data/assets_mac"
    case tvOS = "data/assets_tv"
    case watchOS = "data/assets_watch"

    var path: String {
        guard let bundle = testBundle else {
            fatalError("Missing bundle")
        }

        guard let path = bundle.pathForResource(self.rawValue, ofType: "car") else {
            fatalError("Missing car file")
        }

        return path
    }
}

struct AssetsContainer {
    var iOS: AssetsCatalog!
    var iPad: AssetsCatalog!
    var iPhone: AssetsCatalog!
    var macOS: AssetsCatalog!
    var tvOS: AssetsCatalog!
    var watchOS: AssetsCatalog!

    init() {
        do {
            iOS = try AssetsCatalog(path: Asset.iOS.path)
            iPad = try AssetsCatalog(path: Asset.iPad.path)
            iPhone = try AssetsCatalog(path: Asset.iPhone.path)
            macOS = try AssetsCatalog(path: Asset.macOS.path)
            tvOS = try AssetsCatalog(path: Asset.tvOS.path)
            watchOS = try AssetsCatalog(path: Asset.watchOS.path)
        } catch {
            fatalError("Cannot create assets")
        }
    }
}

let assetsContainer = AssetsContainer()
