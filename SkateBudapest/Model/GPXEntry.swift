//
//  GPXEntry.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 07. 21..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import Foundation

class GPXEntry: NSObject {
    // MARK: Properties
    var images = [PlaceImage]()
    var attributes = [String: String]()

    var name: String {
        return attributes[GPX.Tag.name.rawValue]!
    }
}
