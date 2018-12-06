//
//  ImageUrlRealmModel.swift
//  SkateBudapest
//
//  Created by Horváth Balázs on 2018. 12. 06..
//  Copyright © 2018. Horváth Balázs. All rights reserved.
//

import RealmSwift

class ImageUrlRealmModel: Object {
    @objc dynamic var name = ""

    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
