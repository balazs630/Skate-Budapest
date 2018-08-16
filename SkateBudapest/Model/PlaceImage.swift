//
//  PlaceImage.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class PlaceImage {
    // MARK: Properties
    private var href: String
    var url: URL? { return URL(string: href) }
    var imageAttributes = [String: String]()
    var type: String? { return imageAttributes[GPX.Tag.imageType.rawValue] }

    // MARK: Initializers
    init(href: String) {
        self.href = href
    }
}

extension Array where Element == PlaceImage {
    func imageURLsFor(type: String) -> [URL?] {
        var imageUrls = [URL]()
        for image in self where image.type == type {
            if let imageUrl = image.url {
                imageUrls.append(imageUrl)
            }
        }

        return imageUrls
    }
}
