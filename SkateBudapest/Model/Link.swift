//
//  Link.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class Link {
    var href: String
    var linkAttributes = [String: String]()
    var url: URL? { return URL(string: href) }
    var text: String? { return linkAttributes["text"] }
    var type: String? { return linkAttributes["type"] }

    init(href: String) {
        self.href = href
    }
}
