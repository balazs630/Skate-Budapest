//
//  Image.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class Image {
    var href: String
    var imageAttributes = [String: String]()
    var url: URL? { return URL(string: href) }
    var type: String? { return imageAttributes[GPX.Tag.imageType.rawValue] }

    init(href: String) {
        self.href = href
    }
}
