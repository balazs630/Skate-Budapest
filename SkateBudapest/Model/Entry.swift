//
//  Entry.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class Entry: NSObject {
    var links = [Link]()
    var attributes = [String: String]()

    var name: String? {
        set { attributes["name"] = newValue }
        get { return attributes["name"] }
    }
}
