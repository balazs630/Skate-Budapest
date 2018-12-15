//
//  ImageUrlRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

final class ImageUrlRealmModel: Object {
    @objc dynamic var name = ""

    override class func primaryKey() -> String? {
        return "name"
    }
}

// MARK: Initializers
extension ImageUrlRealmModel {
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
