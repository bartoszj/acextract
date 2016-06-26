//
//  Assets.swift
//  acextract
//
//  Created by Bartosz Janda on 25.06.2016.
//  Copyright © 2016 Bartosz Janda. All rights reserved.
//

import Foundation

enum Asset: String {
    // MARK: Cases
    case iOS = "data/assets_ios"
    case iPhone = "data/assets_iphone"
    case iPad = "data/assets_ipad"
    case macOS = "data/assets_mac"
    case tvOS = "data/assets_tv"
    case watchOS = "data/assets_watch"
    case assets = "data/assets"

    // MARK: Properties
    var path: String {
        guard let path = Asset.path(catalog: self) else {
            fatalError("Missing car file")
        }

        return path
    }

    // MARK: Static
    static let bundleIdentifer = "com.bjanda.acextractTests"
    static let bundle = NSBundle(identifier: bundleIdentifer)!
    static func path(name name: String) -> String? {
        return bundle.pathForResource(name, ofType: "car")
    }
    static func path(catalog catalog: Asset) -> String? {
        return path(name: catalog.rawValue)
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
